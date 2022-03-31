.PHONY: all doc vivado lint-verilator clean test 

all: lint-verilator test vivado doc

doc:
	cd docs && $(MAKE)

vivado:
	cd impl && $(MAKE) vivado

lint-verilator:
	verilator -I./rtl/inc/ -lint-only -Wall ./rtl/inc/jedro_1_defines.sv \
											./rtl/*.sv \
											./rtl/alu/adder/*.v \
											./rtl/alu/compare/*.v \
											./rtl/alu/shift/*.v \

clean:
	cd impl && $(MAKE) clean
	cd doc && $(MAKE) clean
	cd tb && $(MAKE) clean

test:
	$(MAKE) -C tb/ all 


