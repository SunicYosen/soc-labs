#==========================
# Make file for dc
#==========================

BASE_DIR    = $(abspath .)
SCRIPT_DIR  = $(BASE_DIR)/scripts
WORK_DIR    = $(BASE_DIR)/work
RUN_DIR     = $(WORK_DIR)/run
LOG_DIR     = $(WORK_DIR)/log
MAPPED_DIR  = $(WORK_DIR)/mapped
REPROTS_DIR = $(WORK_DIR)/reports

MAIN_SCRIPT = $(SCRIPT_DIR)/dc.tcl
RUN_LOG     = $(WORK_DIR)/run.log

DC          = dc_shell

DC_OPTS     = 

default: run

.PHONY: run
run: $(MAIN_SCRIPT)
	mkdir -p $(RUN_DIR) && \
	cd $(RUN_DIR) && \
	$(DC) $(DC_OPTS) -f $^ > $(RUN_LOG)

#------------------------------------
# Clean
#------------------------------------
.PHONY: clean_run clean_reports clean_mapped clean_all clean
clean_run:
	rm -rf $(RUN_DIR) $(RUN_LOG) $(LOG_DIR)

clean_reports:
	rm -rf $(REPROTS_DIR)

clean_mapped:
	rm -rf $(MAPPED_DIR)

clean_all: clean_run clean_reports clean_mapped
clean: clean_all
