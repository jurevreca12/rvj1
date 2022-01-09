.PHONY: all clean

all: riscof_work

riscof_work:
	riscof run --config=config.ini --suite=../riscv-arch-test/riscv-test-suite/ --env=../riscv-arch-test/riscv-test-suite/env

clean:
	rm -rf riscof_work/
    
    
