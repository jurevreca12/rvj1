.PHONY: all doc vivado lint-verilator clean test 

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
INC_DIR := ${MKFILE_DIR}/rtl/inc
RTL_DIR := ${MKFILE_DIR}/rtl
TB_SUPPORT_DIR := ${MKFILE_DIR}/tb/support

V_FILES := $(shell find ${RTL_DIR} ${TB_SUPPORT_DIR} -name "*.v")
SV_FILES := $(shell find ${RTL_DIR} ${TB_SUPPORT_DIR} -name "*.sv")
RTL_FILES := ${V_FILES} ${SV_FILES}

all: lint-verilator test vivado doc

doc:
	cd docs && $(MAKE)

vivado:
	cd impl && $(MAKE) vivado

lint-verilator:
	verilator -I${INC_DIR} -lint-only -Wall -Wno-fatal ${RTL_FILES}

clean:
	cd impl && $(MAKE) clean
	cd doc && $(MAKE) clean
	cd tb && $(MAKE) clean

test:
	cd tb && $(MAKE) all 


