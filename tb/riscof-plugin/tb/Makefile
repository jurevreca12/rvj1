.PHONY: all compile elaborate sim clean
# We use find to search for all verilog and system verilog files.
INC_DIR := ../../../rtl/inc
JEDRO_1_DEFINES := $(INC_DIR)/jedro_1_defines.v
RTL_DIR := ../../../rtl
TB_SUPPORT_DIR := ../../support/.
ALU_DIR := $(RTL_DIR)/alu
ALU_ADDER_DIR := $(ALU_DIR)/adder
ALU_COMP_DIR := $(ALU_DIR)/compare
ALU_SHIFT_DIR := $(ALU_DIR)/shift
ALU_SIGN_DIR := $(ALU_DIR)/sign_extension

# Add directiores to search path for preqrequisits
VPATH := $(RTL_DIR):\
				 $(INC_DIR):\
				 $(TB_SV_DIR):\
				 $(TB_SUPPORT_DIR):\
				 $(ALU_ADDER_DIR):\
 				 $(ALU_COMP_DIR):\
				 $(ALU_SHIFT_DIR):\
				 $(ALU_SIGN_DIR)

#V_PATHS := $(shell find $(RTL_DIR) $(TB_DIR) -name "*.v")
V_FILES := $(shell find $(RTL_DIR) . $(TB_SUPPORT_DIR) -name "*.v" -print0 | xargs -0 basename -a)
#SV_PATHS := $(shell find $(RTL_DIR) $(TB_DIR) -name "*.sv")
SV_FILES := $(shell find $(RTL_DIR) . $(TB_SUPPORT_DIR) -name "*.sv" -print0 | xargs -0 basename -a)
COMPILED_SV_MODULES := $(SV_FILES:.sv=.sdb)
COMPILED_SV_MODULES := $(addprefix xsim.dir/work/, $(COMPILED_SV_MODULES))
COMPILED_V_MODULES := $(V_FILES:.v=.sdb)
COMPILED_V_MODULES := $(addprefix xsim.dir/work/, $(COMPILED_V_MODULES))
TB_FILES := $(shell find $(TB_SV_DIR) -name "*.v" -print0 | xargs -0 basename -a)

# Elaboration files are contained in xsim.dir/SIM_NAME/xsimk
ELABORATED_TB_MODULES := $(TB_FILES:.v=_simsnap/xsimk)
ELABORATED_TB_MODULES := $(addprefix xsim.dir/, $(ELABORATED_TB_MODULES)) 

# Contain the final simulation
FIN_WDB_FILES := $(TB_FILES:.v=_simsnap.wdb)

# Used for multithreading
################################
# TARGETS
################################
all:; @$(MAKE) _all -j8 --output-sync
_all: compile elaborate sim

compile: $(COMPILED_SV_MODULES) $(COMPILED_V_MODULES)

elaborate: $(ELABORATED_TB_MODULES)

sim: $(FIN_WDB_FILES)

$(FIN_WDB_FILES): ${ELABORATED_TB_MODULES}
	$(eval EL_MODULE=$(subst .wdb,, $@))
	xsim ${EL_MODULE} -R

$(ELABORATED_TB_MODULES): $(COMPILED_SV_MODULES) $(COMPILED_V_MODULES)
	$(eval C_MODULE=$(subst xsim.dir/,, $@))
	$(eval C_MODULE=$(subst _simsnap/xsimk,, ${C_MODULE}))
	xelab --nolog -debug typical -i $(INC_DIR) ${C_MODULE} -s ${C_MODULE}_simsnap --O0

$(COMPILED_SV_MODULES): xsim.dir/work/%.sdb: %.sv
	xvlog -sv -nolog $(JEDRO_1_DEFINES) $< -i $(INC_DIR)

$(COMPILED_V_MODULES): xsim.dir/work/%.sdb: %.v
	xvlog -nolog $(JEDRO_1_DEFINES) $< -i $(INC_DIR)

clean:
	rm -rf xelab.* xsim.dir/ xsim* xvlog.* webtalk* *.wdb *.vcd Xil./ *.str

