FIGFILES = scope.fig
EPSFILES = 2cg_catalog.eps 3eg_catalog.eps tev_catalog.eps \
	   egret_ul.eps sensitivity_VHE_3eg.eps

TARGETS = $(FIGFILES:.fig=.pdf) $(EPSFILES:.eps=.pdf)

all: $(TARGETS)

clean:
	$(RM) -f $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	epstopdf -o=$@ $<
