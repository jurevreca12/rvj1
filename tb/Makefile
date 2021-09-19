.PHONY: all cocotb clean

all:	cocotb

cocotb:
	cd cocotb && $(MAKE)

sv:
	cd sv && $(MAKE)

clean:
	cd cocotb && $(MAKE) clean      	# clean is already defined by cocotb makefile,
	cd cocotb && $(MAKE) clean_other	# but we need to remove some additional files.





