FROM hpretl/iic-osic-tools:2026.06
USER root
RUN apt update && \
    apt install -y --only-upgrade python3-pip && \
    apt install -y python3-dev \
                   boolector

RUN useradd -m -u 1000 developer
USER developer

RUN pip install  "cython<3.0.0" wheel && \
    pip install  "PyYAML==5.2" --no-build-isolation && \ 
    pip install vcs_versioning pyelftools && \
    pip install git+https://github.com/jurevreca12/forastero.git@f546470 \
                git+https://github.com/riscv-software-src/riscv-config@54171f2 \
                git+https://github.com/riscv-software-src/riscv-isac@777d2b4 \
                git+https://github.com/riscv-software-src/riscof@aa146d4 \
                git+https://github.com/jurevreca12/pyspike.git@928524b \
                git+https://github.com/jurevreca12/riscv-python-model@24daba0 && \
    pip install git+https://github.com/cocotb/cocotb.git@c463647 # installed separetly - version conflict

USER root
RUN curl -L https://github.com/sifive/elf2hex/archive/refs/tags/v20.08.00.00.tar.gz -o elf2hex.tar.gz && \
    tar -xvzpf elf2hex.tar.gz && \
    rm elf2hex.tar.gz && \
    cd elf2hex-* && \
    ./configure --target=riscv32-unknown-elf && \
    make && \
    make install && \
    cd .. && \
    rm -rf elf2hex-*

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

RUN cd /foss/tools/ && \
    git clone https://github.com/chipsalliance/riscv-dv && \
    cd riscv-dv && \
    git checkout b7a0b4b && \
    pip install -r requirements.txt && \
    pip install zombie-imp && \
    pip install -e .
ENV RISCV_DV=/foss/tools/riscv-dv

RUN pip install --force-reinstall pytest && \
    pip install pytest-xdist

WORKDIR /foss/designs/rvj1
