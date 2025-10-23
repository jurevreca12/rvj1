# rvj1 - A simple RISC-V core

The rvj1 core implements the classic 5 stage pipeline. The pipeline is shown in the diagram bellow.

![Diagram of the rvj1 pipeline.](doc/img/rvj1_stages.svg)

## Getting started
The core uses open source tools to implement the design. To recreate the development enviroment use the following code snippet:
```
git clone --recurse-submodules https://github.com/jurevreca12/rvj1.git
cd rvj1
make docker-build
make docker-run-it
```
This will clone the repository and start a docker container that contains the tools needed for rvj1 development.

## Simulating the core
Currently there are two types of tests available. One type is based on the cocotb and forastero library in _tb/cocotb/_ and the other type of testing is based on the riscv architectural tests and the riscof library in _tb/riscof-plugin_.

To run all cocotb test simply run:
```
cd tb
make cocotb
```
or to run a specific cocotb test use:
```
cd tb/cocotb/
python test_ifu.py
python test_lsu.py
python test_insn.py
```
It is also possible to run a specific test case by:
```
WAVES=1 COCOTB_TEST_FILTER="addi" python test_insn.py
```
Here we also specify that we want to dump a .fst file for debuging.

To run the riscv architectural tests:
```
cd tb/
make riscof
```


