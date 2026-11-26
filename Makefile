THIS_MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(THIS_MAKEFILE_DIR)/common.mk

.PHONY: sim_flist sim_flist_rvj1_ifu, sim_flist_rvj1_ifu_rvc , sim_flist_lsu
.PHONY: devtreeblob 
.PHONY: devcontainer-up devcontainer-exec

# Filelists
BENDER_SIM_ARGS := -t rtl -t sim 

$(BUILD_CONFIG_SIM_FLIST): $(BENDER_YAML_FILE)
	mkdir -p $(BUILD_CONFIG_DIR)
	$(BENDER) script flist-plus $(BENDER_SIM_ARGS) > $(BUILD_CONFIG_SIM_FLIST)

$(BUILD_IFU_SIM_FLIST):
	mkdir -p $(BUILD_IFU_DIR)
	$(BENDER) script --top ifu_mem_test_top flist-plus $(BENDER_SIM_ARGS) > $(BUILD_IFU_SIM_FLIST)

$(BUILD_IFU_RVC_SIM_FLIST):
	mkdir -p $(BUILD_IFU_RVC_DIR)
	$(BENDER) script --top ifu_mem_test_top flist-plus $(BENDER_SIM_ARGS) > $(BUILD_IFU_RVC_SIM_FLIST)

$(BUILD_LSU_SIM_FILST):
	mkdir -p $(BUILD_LSU_DIR)
	$(BENDER) script --top lsu_mem_test_top flist-plus $(BENDER_SIM_ARGS) > $(BUILD_LSU_SIM_FILST)

sim_flist: $(BUILD_CONFIG_SIM_FLIST)
sim_flist_rvj1_ifu: $(BUILD_IFU_SIM_FLIST)
sim_flist_rvj1_ifu_rvc: $(BUILD_IFU_RVC_SIM_FLIST)
sim_flist_lsu: $(BUILD_LSU_SIM_FILST)

# Device Tree Blobs
$(BUILD_CONFIG_DTB): $(SCRIPTS_DTS)
	mkdir -p $(BUILD_CONFIG_DIR)
	$(DTC) -o $(BUILD_CONFIG_DTB) $(SCRIPTS_DTS)
	
devtreeblob: $(BUILD_CONFIG_DTB)

devcontainer-up:                                        
	devcontainer up --workspace-folder $(THIS_MAKEFILE_DIR)      

devcontainer-exec:                                      
	devcontainer exec --workspace-folder $(THIS_MAKEFILE_DIR) bash

