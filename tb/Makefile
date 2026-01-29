.PHONY: all riscof cocotb clean

all:	riscof

cocotb:
	cd cocotb && pytest

riscof: 
	riscof -v info run \
           --config=/foss/designs/rvj1/tb/riscof-plugin/config.ini \
           --suite=/foss/designs/rvj1/tb/riscv-arch-test/riscv-test-suite/ \
           --env=/foss/designs/rvj1/tb/riscv-arch-test/riscv-test-suite/env

clean:
	rm -rf riscof_work/
	rm -rf cocotb/sim_build
	rm -rf cocotb/__pycache__
	rm -f cocotb/results.xml
