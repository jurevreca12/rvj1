.PHONY: all riscof cocotb clean

all:	riscof

cocotb:
	cd cocotb && pytest

riscof: 
	riscof -v info run --config=riscof-plugin/config.ini --suite=riscv-arch-test/riscv-test-suite/ --env=riscv-arch-test/riscv-test-suite/env

clean:
	rm -rf riscof_work/
	rm -rf cocotb/sim_build
	rm -rf cocotb/__pycache__
	rm cocotb/results.xml
