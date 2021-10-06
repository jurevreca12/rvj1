.PHONY: all compile clean
# We use find to search for all verilog and system verilog files.
INC_FOLDER := ../../rtl/inc/
JEDRO_1_DEFINES := $(INC_FOLDER)jedro_1_defines.sv
RTL_DIR := ../../rtl
TB_DIR := ../.
TB_SV_DIR := .
TB_SUPPORT_DIR := ../support/.
ALU_DIR := $(RTL_DIR)/alu
ALU_ADDER_DIR := $(ALU_DIR)/adder
ALU_COMP_DIR := $(ALU_DIR)/compare
ALU_SHIFT_DIR := $(ALU_DIR)/shift
ALU_SIGN_DIR := $(ALU_DIR)/sign_extension

# Add directiores to search path for preqrequisits
vpath %.sv $(RTL_DIR) $(INC_DIR) $(TB_SV_DIR) $(TB_SUPPORT_DIR) $(ALU_ADDER_DIR)\
 					 $(ALU_COMP_DIR) $(ALU_SHIFT_DIR) $(ALU_SIGN_DIR)
vpath %.v $(RTL_DIR) $(INC_DIR) $(TB_SV_DIR) $(TB_SUPPORT_DIR) $(ALU_ADDER_DIR)\
 				 	$(ALU_COMP_DIR) $(ALU_SHIFT_DIR) $(ALU_SIGN_DIR)

#V_PATHS := $(shell find $(RTL_DIR) $(TB_DIR) -name "*.v")
V_FILES := $(shell find $(RTL_DIR) $(TB_DIR) -name "*.v" -print0 | xargs -0 basename -a)
#SV_PATHS := $(shell find $(RTL_DIR) $(TB_DIR) -name "*.sv")
SV_FILES := $(shell find $(RTL_DIR) $(TB_DIR) -name "*.sv" -print0 | xargs -0 basename -a)
COMPILED_SV_MODULES := $(SV_FILES:.sv=.wdb)
COMPILED_SV_MODULES := $(addprefix xsim.dir/work/, $(COMPILED_SV_MODULES))
COMPILED_V_MODULES := $(V_FILES:.v=.wdb)
COMPILED_V_MODULES := $(addprefix xsim.dir/work/, $(COMPILED_V_MODULES))

################################
# TARGETS
################################
all: compile

compile: $(COMPILED_SV_MODULES) $(COMPILED_V_MODULES)

$(COMPILED_SV_MODULES): xsim.dir/work/%.wdb: %.sv
	xvlog -sv $(JEDRO_1_DEFINES) $< -i $(INC_FOLDER)

$(COMPILED_V_MODULES): xsim.dir/work/%.wdb: %.v
	xvlog -sv $(JEDRO_1_DEFINES) $< -i $(INC_FOLDER)

clean:
	rm -rf xelab.* xsim.dir/ xsim* xvlog.* webtalk* *.wdb *.vcd Xil./

