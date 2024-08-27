# Makefile
#
# Converts the markdown file `pres.md` to `pres.html`
# Requires Mathjax and RevealJS to be installed as explained in `README.md`
# If a file `template.md` exists, it will be used as the template instead of
# default.revealjs

SOURCE :=  pres.md

DEST = $(SOURCE:.md=.html)

RM = /bin/rm

PANDOC = pandoc

PANDOC_OPTIONS = -s --mathjax=mathjax/MathJax.js -i -t revealjs -V center=false -V history=false -V revealjs-url=reveal.js

ifneq ($(wildcard template.md),)
	OPTIONAL_TEMPLATE = --template=template.md
else
	OPTIONAL_TEMPLATE = 
endif

# Pattern-matching Rules

%.html : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(OPTIONAL_TEMPLATE) -o $@ $<

# Targets and dependencies

.PHONY: all clean

all : $(DEST)

clean:
	- $(RM) $(DEST)
