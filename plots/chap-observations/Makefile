FIGFILES = 
EPSFILES = sources.eps sed0433.eps sed0450.eps sed0508.eps sed0628.eps
SUBDIRS  = spectra loenergy 
CLEANSUB = $(addprefix clean-,$(SUBDIRS))

TARGETS = $(EPSFILES:.eps=.pdf) $(FIGFILES:.fig=.pdf)
ALLTARGETS = $(TARGETS) $(SUBDIRS)

.PHONY: $(SUBDIRS) $(CLEANSUB) clean all

all: $(ALLTARGETS)

clean: $(CLEANSUB)
	$(RM) $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~

$(SUBDIRS):
	$(MAKE) -C $@

$(CLEANSUB):
	$(MAKE) -C $(subst clean-,,$@) clean

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	epstopdf -o=$@ $<
