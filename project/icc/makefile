#==========================
# Make file for dc
#==========================
TOP_NAME    = cnn_acc
BASE_DIR    = $(abspath ..)
ICC_DIR     = $(BASE_DIR)/icc
SCRIPT_DIR  = $(ICC_DIR)/scripts
MAPPED_DIR  = $(ICC_DIR)/mapped
WORK_DIR    = $(BASE_DIR)/work/$(TOP_NAME)/icc
RUN_DIR     = $(WORK_DIR)/run
LOG_DIR     = $(WORK_DIR)/log
REPROTS_DIR = $(WORK_DIR)/reports

MAIN_SCRIPT = $(SCRIPT_DIR)/icc.tcl
RUN_LOG     = $(WORK_DIR)/run.log

ICC          = icc_shell

ICC_OPTS     = 

default: run

.PHONY: run
run: $(MAIN_SCRIPT)
	mkdir -p $(RUN_DIR) && \
	cd $(RUN_DIR) && \
	$(ICC) $(ICC_OPTS) -f $^ > $(RUN_LOG)

#------------------------------------
# Clean
#------------------------------------
.PHONY: clean_run clean_reports clean_mapped clean_all clean
clean_run:
	rm -rf $(RUN_DIR) $(RUN_LOG) $(LOG_DIR)

clean_reports:
	rm -rf $(REPROTS_DIR)

clean_mapped:
	rm $(MAPPED_DIR)/*

clean_all: clean_run clean_reports clean_mapped
clean: clean_all
