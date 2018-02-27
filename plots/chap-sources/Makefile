FIGFILES = 
EPSFILES = ebl_opacity.eps ebl_spectrum.eps

TARGETS = $(FIGFILES:.fig=.pdf) $(EPSFILES:.eps=.pdf)

all: $(TARGETS)

clean:
	$(RM) -f $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	epstopdf -o=$@ $<
