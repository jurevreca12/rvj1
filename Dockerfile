FROM hpretl/iic-osic-tools:2025.12

RUN pip install --upgrade pip && \
    pip install "cython<3.0.0" wheel && \
    pip install "PyYAML==5.2" --no-build-isolation && \
    pip install cocotb==2.0.0 && \
    pip install git+https://github.com/jurevreca12/forastero.git@09c1817 && \
    pip install git+https://github.com/jurevreca12/riscv-python-model@24daba0 && \
    pip uninstall -y riscv-config && \
    pip install git+https://github.com/riscv-software-src/riscv-config@54171f2 && \
    pip install git+https://github.com/riscv-software-src/riscof@aa146d4 && \
    pip uninstall -y riscv-isac && \
    pip install git+https://github.com/riscv-software-src/riscv-isac@777d2b4

USER 0:0
RUN curl -L https://github.com/sifive/elf2hex/archive/refs/tags/v20.08.00.00.tar.gz -o elf2hex.tar.gz && \
    tar -xvzpf elf2hex.tar.gz && \
    rm elf2hex.tar.gz && \
    cd elf2hex-20.08.00.00 && \
    ./configure --target=riscv32-unknown-elf && \
    make && \
    make install && \
    cd .. && \
    rm -rf elf2hex*

RUN cd /foss/tools && \
    git clone https://github.com/openXC7/prjxray.git && \
    cd prjxray && \
    git checkout e87c79a && \
    git submodule init && \
    git submodule update && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    pip install -r requirements.txt && \
    sed -i "3i sys.path.append('/foss/tools/prjxray')" /usr/local/bin/fasm2frames

RUN cd /foss/tools/ && \
    git clone https://github.com/f4pga/prjxray-db

RUN apt install -y libboost-all-dev \
                   libantlr4-runtime-dev 

RUN cd /foss/tools && \
    git clone https://github.com/janrinze/nextpnr-openxc7.git nextpnr-xilinx && \
    cd nextpnr-xilinx && \
    git checkout 453cbdf && \
    git submodule init && \
    git submodule update && \
    #sed -i "345i net_old_indices.emplace_back();" ./frontend/frontend_base.h && \
    #sed -i "511i net_old_indices.emplace_back();" ./frontend/frontend_base.h && \
    #sed -i "447i auto cell_type = impl.get_cell_type(cd);" ./frontend/frontend_base.h && \
    #sed -i "448i if (cell_type == \"\$scopeinfo\")" ./frontend/frontend_base.h && \
    #sed -i "449i return;" ./frontend/frontend_base.h && \
    mkdir build && \
    sed -i "s/add_definitions(\${EIGEN3_DEFINITIONS})//g" CMakeLists.txt && \
    cd build && \
    cmake -DARCH=xilinx  .. && \
    make -j$(nproc) && \
    make install
RUN cd /foss/tools/nextpnr-xilinx && \
    python xilinx/python/bbaexport.py --device xc7a100tcsg324-1 --bba xilinx/xc7a100t.bba && \
    ./build/bbasm -l xilinx/xc7a100t.bba xilinx/xc7a100t.bin && \
    rm xilinx/xc7a100t.bba


#RUN git clone https://github.com/verilog-to-routing/vtr-verilog-to-routing && \
#    cd vtr-verilog-to-routing && \
#    git checkout f9ff125 && \
#    git submodule init && \
#    git submodule update && \
#    make vpr  

#RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py312_25.11.1-1-Linux-x86_65.sh -O conda_installer.sh && \
#    export F4PGA_INSTALL_DIR=/foss/tools/f4pga && \
#    export FPGA_FAM=xc7 && \
#    bash conda_installer.sh -u -b -p $F4PGA_INSTALL_DIR/$FPGA_FAM/conda && \
#    rm conda_installer.sh 
#    /bin/bash -c "source $F4PGA_INSTALL_DIR/$FPGA_FAM/conda/etc/profile.d/conda.sh" && \
#    export PATH=$PATH:"/foss/tools/f4pga/xc7/conda/bin/" && \
#    echo "export PATH=\$PATH:/foss/tools/f4pga/xc7/conda/bin/" >> /headless/.bashrc && \
#    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
#    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r  && \
#    git clone https://github.com/chipsalliance/f4pga-examples && \
#    cd f4pga-examples && \
#    git checkout 8f1e49e && \
#    cd xc7 && \
#    conda env create -y -f environment.yml && \ 
#    export F4PGA_PACKAGES='install-xc7 xc7a100t_test' && \
#    mkdir -p $F4PGA_INSTALL_DIR/$FPGA_FAM && \
#    cd ../.. && \
#    rm -rf f4pga-examples && \
#    wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/20230411-180123/symbiflow-arch-defs-xc7a100t_test-5e974a8.tar.xz | tar -xJC $F4PGA_INSTALL_DIR/${FPGA_FAM} 

#RUN wget micro.mamba.pm/install.sh && \
#    bash install.sh && \
#    rm install.sh 
#RUN export F4PGA_INSTALL_DIR=/foss/tools/f4pga && \
#    export FPGA_FAM=xc7 && \
#    git clone https://github.com/chipsalliance/f4pga-examples && \
#    cd f4pga-examples && \
#    git checkout f4pga && \
#    cd xc7 #&&
#    ~/.local/bin/micromamba env create -y -f environment.yml && \ 
#    export F4PGA_PACKAGES='install-xc7 xc7a100t_test' && \
#    mkdir -p $F4PGA_INSTALL_DIR/$FPGA_FAM && \
#    cd ../.. && \
#    rm -rf f4pga-examples && \
#    wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/20230411-180123/symbiflow-arch-defs-xc7a100t_test-5e974a8.tar.xz | tar -xJC $F4PGA_INSTALL_DIR/${FPGA_FAM} 

WORKDIR /foss/designs/rvj1
