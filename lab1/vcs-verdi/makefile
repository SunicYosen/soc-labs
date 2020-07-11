#----------------------------------------------
# makefile for vcs
# SunicYosen
# 2020.05.28
#----------------------------------------------
TOP_NAME     ?= conv_top
BASE_DIR      = $(abspath ..)
SRC_DIR       = $(BASE_DIR)/src
RTL_DIR       = $(SRC_DIR)/rtl
TB_DIR        = $(SRC_DIR)/tb
VCS_VERDI_DIR = $(BASE_DIR)/vcs-verdi

WORK_DIR     = $(BASE_DIR)/work
VCS_WORK_DIR = $(WORK_DIR)/$(TOP_NAME)/vcs
VCS_COM_DIR  = $(VCS_WORK_DIR)/csrc

VERDI_WORK_DIR = $(WORK_DIR)/$(TOP_NAME)/verdi
VERDI_LOG_DIR  = $(VERDI_WORK_DIR)/verdiLog

files_list = $(VCS_VERDI_DIR)/file.f

VSRC        = $(RTL_DIR)/mac.v         \
              $(RTL_DIR)/pe3.v         \
              $(RTL_DIR)/pe33.v        \
              $(RTL_DIR)/relu.v        \
			  $(RTL_DIR)/fifo.v        \
              $(RTL_DIR)/conv.v        \
              $(RTL_DIR)/conv_top.v    \
              $(TB_DIR)/$(TOP_NAME)_tb.v

FSDB_FILE    ?= $(VCS_WORK_DIR)/$(TOP_NAME).fsdb
COM_LOG_FILE ?= $(VCS_WORK_DIR)/$(TOP_NAME)_compile.log
RUN_LOG_FILE ?= $(VCS_WORK_DIR)/$(TOP_NAME)_run.log


VCS = vcs
VCS_OPTS = -full64 -sverilog \
           -LDFLAGS -Wl,--no-as-needed \
		   -timescale=1ns/10ps \
		   -debug_access+r+w+nomemcbk -debug_region+cell+encrypt\
		   -Mdir=$(VCS_COM_DIR) -Mupdate\
		   -l $(COM_LOG_FILE) \
		   +vpi +notimingcheck \
		   +define+FSDB_ON \
		   +define+FSDB_FILE

# Verdi
VCS_OPTS += -P ${VERDI_HOME}/share/PLI/VCS/LINUXAMD64/novas.tab \
               ${VERDI_HOME}/share/PLI/VCS/LINUXAMD64/pli.a

# Run
RUN_FLAGS = +fsdbfile=$(FSDB_FILE)

# Verdi OPTIONS
VEIDI_OPTS = -sv +v2k \
             -logdir $(VERDI_LOG_DIR) \

BIN = $(VCS_WORK_DIR)/$(TOP_NAME).vsim

default: $(BIN)

$(BIN): $(VSRC)
	mkdir -p $(VCS_WORK_DIR) && \
	$(VCS) $(VCS_OPTS) $^ -o $@

run: $(BIN)
	$(BIN) $(RUN_FLAGS) > $(RUN_LOG_FILE)

$(FSDB_FILE): $(BIN)
	$(BIN) $(RUN_FLAGS) > $(RUN_LOG_FILE)

.PHONY: verdi
verdi: $(FSDB_FILE)
	verdi $(VEIDI_OPTS) -f $(files_list) -ssf $(FSDB_FILE)

.PHONY: clean
clean:
	rm -rf $(VCS_WORK_DIR) $(VERDI_WORK_DIR) ucli.key
