CHAPTERS=chap-title.tex \
         chap-introduction.tex \
         chap-sources.tex \
         chap-technique.tex \
         chap-analysis.tex \
         chap-observations.tex \
         chap-veritas.tex \
	 chap-conclusions.tex \
         app-jargon.tex \
         app-ellipt.tex \
         app-smoothing.tex \
         app-liandma.tex
TARGETS=sjf-thesis.pdf sjf-thesis.ps

all: pdf view

pdf: plots sjf-thesis.pdf

gs: sjf-thesis.ps
	ghostview $<

ps: sjf-thesis.ps

view: sjf-thesis.pdf
	acroread $<

plots:
	$(MAKE) -C plots

clean-plots:
	$(MAKE) -C plots clean

sjf-thesis.pdf: sjf-thesis.tex $(CHAPTERS) references.bib thesis.cls

sjf-thesis.ps: sjf-thesis.pdf
	acroread -toPostScript -size letter $< .

clean:
	$(RM) $(TARGETS) *.aux *.log *.toc *.out *.bbl *.blg *.lof *.lot *~

allclean: clean-plots clean

%.pdf: %.tex
	pdfelatex $< </dev/null
	bibtex $(<:.tex=)
	pdfelatex $< </dev/null
	pdfelatex $< </dev/null

.PHONY: plots clean clean-plots

