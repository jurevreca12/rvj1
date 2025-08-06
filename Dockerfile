FROM hpretl/iic-osic-tools:2025.07

RUN pip install --upgrade pip && \
    pip install forastero==1.2.1 

RUN pip install "cython<3.0.0" wheel && \
    pip install "PyYAML==5.2" --no-build-isolation && \
    pip install  riscof==1.25.3

USER 0:0
RUN git clone --recursive --depth 1 --shallow-submodules https://github.com/riscv/riscv-gnu-toolchain.git && \
    cd ./riscv-gnu-toolchain && \
    ./configure --prefix=/usr/local/bin --with-arch=rv32i --with-abi=ilp32 && \
    make -j $(nproc) && \
    cd .. && \
    rm -rf riscv-gnu-toolchain
ENV PATH="$PATH:/usr/local/bin/bin"

RUN curl -L https://github.com/sifive/elf2hex/archive/refs/tags/v20.08.00.00.tar.gz -o elf2hex.tar.gz && \
    tar -xvzpf elf2hex.tar.gz && \
    rm elf2hex.tar.gz && \
    cd elf2hex-20.08.00.00 && \
    ./configure --target=riscv32-unknown-elf && \
    make && \
    make install

WORKDIR /foss/designs/riscv-jedro-1
