FROM ubuntu:22.04

RUN apt-get -y update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install autoconf \
	               			       				       automake \
	               			       				       autotools-dev \
	               			       				       curl \
	               			       				       python3 \
	               			       				       python3-dev \
	               			       				       python3-pip \
	               			       				       libmpc-dev \
      	               			       				       libmpfr-dev \
	               			       				       libgmp-dev \
	               			       				       gawk \
	               			       				       build-essential \
	               			       				       bison \
	               			       				       flex \
	               			       				       texinfo \
	               			       				       gperf \
	               			       				       libtool \
      	               			       				       patchutils \
	               			       				       bc \
	               			       				       zlib1g-dev \
	               			       				       libexpat-dev \
		       			       				       git \
		       			       				       vim

RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain.git
RUN git clone --recursive https://github.com/riscv/riscv-opcodes.git
RUN cd ./riscv-gnu-toolchain && \
       ./configure --prefix=/usr/local/bin --with-arch=rv32i --with-abi=ilp32 && \
       make
ENV PATH="$PATH:/usr/local/bin/bin"
RUN pip install cocotb riscof

RUN git config --global --add safe.directory /riscv-jedro-1/tb/riscv-arch-test
RUN apt-get install -y opam  build-essential libgmp-dev z3 pkg-config zlib1g-dev && \
    opam init -y --disable-sandboxing && \
    opam switch create 5.1.0 && \
    opam install sail -y && \
    eval $(opam config env) && \
    git clone https://github.com/riscv/sail-riscv.git && \
    cd sail-riscv && \
    make && \
    ARCH=RV32 make && \
    ln -s /sail-riscv/c_emulator/riscv_sim_RV32 /usr/bin/riscv_sim_RV32

# Verilator stuff
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git help2man perl python3 make autoconf g++ flex bison ccache \
 		    libgoogle-perftools-dev numactl perl-doc \
 		    libfl2  \
 		    libfl-dev \
 		    zlib1g zlib1g-dev 

RUN git clone https://github.com/verilator/verilator && \
    cd verilator && \
    git checkout v5.026 && \
    autoconf && \
    ./configure && \
    make -j `nproc` && \
    make install 

RUN curl -L https://github.com/sifive/elf2hex/releases/download/v1.0.1/elf2hex-1.0.1.tar.gz -o elf2hex-1.0.1.tar.gz && \
    tar -xvzpf elf2hex-1.0.1.tar.gz && \
    cd elf2hex-1.0.1 && \
    ./configure --target=riscv32-unknown-elf && \
    make && \
    make install

WORKDIR /riscv-jedro-1
