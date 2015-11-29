####################
# Makefile

RMD_DIR = Rmd
HTML_DIR = slides
HANDOUT_DIR = handouts
SCRIPT_DIR = scripts

RMD_SOURCE = $(wildcard $(RMD_DIR)/*.Rmd)
HANDOUT_SOURCE = $(wildcard $(HANDOUT_DIR)/*.Rmd)

HTML_OUT = $(patsubst $(RMD_DIR)/%.Rmd,$(HTML_DIR)/%.html,$(RMD_SOURCE))
HANDOUT_OUT = $(HANDOUT_SOURCE:.Rmd=.docx)
SCRIPT_OUT = $(patsubst $(RMD_DIR)/%.Rmd,$(SCRIPT_DIR)/%.R,$(RMD_SOURCE))

KNIT_SLIDE = Rscript -e "rmarkdown::render('$<', output_dir = '$(HTML_DIR)')"
KNIT_HANDOUT = Rscript -e "rmarkdown::render('$<', output_format = 'word_document')"
KNIT_BEAMER = Rscript -e "rmarkdown::render('$<', output_dir = '$(HTML_DIR)')"

all: slides handouts scripts

slides: $(HTML_OUT)

handouts: $(HANDOUT_OUT)

scripts: $(SCRIPT_OUT)

$(HTML_DIR)/%.html:$(RMD_DIR)/%.Rmd
	$(KNIT_SLIDE) 

$(HANDOUT_DIR)/%.docx:$(HANDOUT_DIR)/%.Rmd
	$(KNIT_HANDOUT) 
	
$(SCRIPT_DIR)/%.R:$(RMD_DIR)/%.Rmd
	Rscript -e "knitr::purl('$<', output = '$@')"
	
clean:
	rm -f -v $(HTML_OUT)
	rm -f -v $(HANDOUT_OUT)
	rm -f -v $(SCRIPT_OUT)