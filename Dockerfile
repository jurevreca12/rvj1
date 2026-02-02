FROM hpretl/iic-osic-tools:2025.07

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
    cd elf2hex-* && \
    ./configure --target=riscv32-unknown-elf && \
    make && \
    make install && \
    cd .. && \
    rm -rf elf2hex-*

RUN apt install -y boolector 

RUN git clone https://github.com/YosysHQ/riscv-formal && \
    cd riscv-formal && \
    git checkout 3a2512a22e79d5289f90a5ea2d208b21bba7b352 && \
    mkdir /foss/tools/riscv-formal && \
    cp -r ./checks /foss/tools/riscv-formal/ && \
    cp -r ./bus /foss/tools/riscv-formal/ && \
    cp -r ./insns /foss/tools/riscv-formal/ && \
    cp -r ./monitor /foss/tools/riscv-formal/ && \
    cd .. && \
    rm -rf riscv-formal && \
    sed -i "s/basedir\s=\sf\"{os\.getcwd()}\/\.\.\/\.\.\"/basedir = \"\/foss\/tools\/riscv-formal\"/" \
        /foss/tools/riscv-formal/checks/genchecks.py && \
    sed -i "s/corename\s=\sos\.getcwd()\.split(\"\/\")\[-1\]/corename = \"rvj1\"/" \
        /foss/tools/riscv-formal/checks/genchecks.py && \
    sed -i "s/with\sopen(f\"\.\.\/\.\./with open(f\"\/foss\/tools\/riscv-formal/" \
        /foss/tools/riscv-formal/checks/genchecks.py

WORKDIR /foss/designs/rvj1
