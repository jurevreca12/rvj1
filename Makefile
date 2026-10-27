.PHONY: all doc vivado lint-verilator clean test docker-build docker-run-it 

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
INC_DIR := ${MKFILE_DIR}/rtl/inc
RTL_DIR := ${MKFILE_DIR}/rtl
TB_SUPPORT_DIR := ${MKFILE_DIR}/tb/support

V_FILES := $(shell find ${RTL_DIR} ${TB_SUPPORT_DIR} -name "*.v")
SV_FILES := $(shell find ${RTL_DIR} ${TB_SUPPORT_DIR} -name "*.sv")
RTL_FILES := ${V_FILES} ${SV_FILES}

CUID := $(shell id -u)
CGID := $(shell id -g)
CWD  := $(abspath $(dir $$PWD))

all: lint-verilator test vivado doc

doc:
	cd docs && $(MAKE)

vivado:
	cd impl && $(MAKE) vivado

lint-verilator:
	verilator --timescale 1ns/1ps \
			  -DRVFI \
			  -DRVFI_TRACE \
			  -DASSERTIONS \
			  -lint-only \
			  -Wall \
			  -Wno-fatal \
              -f tb/sources.f \
			  --top-module rvj1_top

devcontainer-up:                                        
	devcontainer up --workspace-folder $(MKFILE_DIR)      
                                                        
devcontainer-exec:                                      
	devcontainer exec --workspace-folder $(MKFILE_DIR) bash


clean:
	cd impl && $(MAKE) clean
	cd doc && $(MAKE) clean
	cd tb && $(MAKE) clean

test:
	cd tb && $(MAKE) all 
