####################
# Makefile

RMD_DIR = ./Rmd

HTML_OUT = $(RMD_DIR:.Rmd=.html)

KNIT = Rscript -e "rmarkdown::render('$<')"

all: $(HTML_OUT) 

$(RMD_DIR)/%.html:$(RMD_DIR)/%.Rmd
	$(KNIT) 