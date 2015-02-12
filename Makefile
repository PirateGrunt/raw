####################
# Makefile

RDIR = .
DATA_DIR = $(RDIR)/data

GATHER_DIR = $(DATA_DIR)/gather
PROCESS_DIR = $(DATA_DIR)/process
ANALYSIS_DIR = $(RDIR)/analysis

GATHER_SOURCE = $(wildcard $(GATHER_DIR)/*.Rmd)
GATHER_OUT = $(GATHER_SOURCE:.Rmd=.docx)

PROCESS_SOURCE = $(wildcard $(PROCESS_DIR)/*.Rmd)
PROCESS_OUT = $(PROCESS_SOURCE:.Rmd=.docx)

ANALYSIS_SOURCE = $(wildcard $(ANALYSIS_DIR)/*.Rmd)
ANALYSIS_OUT = $(ANALYSIS_SOURCE:.Rmd=.docx)

KNIT = Rscript -e

all: $(GATHER_OUT) $(PROCESS_OUT) $(ANALYSIS_OUT)

$(GATHER_DIR)/%.docx:$(GATHER_DIR)/%.Rmd
	$(KNIT) "require(rmarkdown); render('$<', word_document())"

$(PROCESS_DIR)/%.docx:$(PROCESS_DIR)/%.Rmd
	$(KNIT) "require(rmarkdown); render('$<', word_document())"

$(ANALYSIS_DIR)/%.docx:$(ANALYSIS_DIR)/%.Rmd
	$(KNIT) "require(rmarkdown); render('$<', word_document())"