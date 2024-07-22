.PHONY: all riscof clean

all:	riscof

riscof: 
	riscof run --config=riscof-plugin/config.ini --suite=riscv-arch-test/riscv-test-suite/ --env=riscv-arch-test/riscv-test-suite/env

clean:
	rm -rf riscof_work/
	cd riscof-plugin/tb && $(MAKE) clean

