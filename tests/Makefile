include ../common.mk

.PHONY: all riscof rvgen rvtests clean

all: riscof rvgen rvtests

riscof:
	$(MAKE) -f riscof.mk all

rvgen:
	$(MAKE) -f rvgen.mk all

rvtests:
	$(MAKE) -f rvtests.mk all

clean:
	rm -rf $(BUILD_TEST_DIR)