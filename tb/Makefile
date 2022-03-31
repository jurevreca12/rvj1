.PHONY: all cocotb riscof basic clean

all:	basic

cocotb:
	cd cocotb && $(MAKE)

basic:
	cd sv && $(MAKE)

clean:
	cd cocotb && $(MAKE) clean      	# clean is already defined by cocotb makefile,
	cd cocotb && $(MAKE) clean_other	# but we need to remove some additional files.
	cd basic  && $(MAKE) clean
	cd riscof-plugin && $(MAKE) clean

