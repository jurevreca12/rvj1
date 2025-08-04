.PHONY: all riscof clean

all:	riscof

riscof: 
	riscof -v info run --config=riscof-plugin/config.ini --suite=riscv-arch-test/riscv-test-suite/ --env=riscv-arch-test/riscv-test-suite/env

clean:
	rm -rf riscof_work/
