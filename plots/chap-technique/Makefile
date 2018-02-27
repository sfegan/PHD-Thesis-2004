FIGFILES = el_schematic.fig
#TREPSFILES = kas_gamm_1000_pd.eps kas_gamm_1000_ph.eps \
#	     kas_gamm_1000_rd.eps kas_gamm_1000_sp.eps \
#	     kas_gamm_1000_tr.eps kas_gamm_100_pd.eps \
#	     kas_gamm_100_ph.eps kas_gamm_100_rd.eps \
#	     kas_gamm_100_sp.eps kas_gamm_100_tr.eps \
#	     kas_muon_99999_pd.eps kas_muon_99999_ph.eps \
#	     kas_muon_99999_rd.eps kas_muon_99999_sp.eps \
#	     kas_muon_99999_tr.eps kas_prot_1000_pd.eps \
#	     kas_prot_1000_ph.eps kas_prot_1000_rd.eps \
#	     kas_prot_1000_sp.eps kas_prot_1000_tr.eps
BZ2EPSFILES = kas_gamm_1000_tr.eps.bz2 kas_gamm_100_tr.eps.bz2 \
	      kas_prot_1000_tr.eps.bz2
EPSFILES = cones.eps fplane_density.eps bias_011009.eps \
           detector_response_area.eps detector_response_drde.eps \
           kas_muon_99999_rd.eps 

TARGETS = $(FIGFILES:.fig=.pdf) \
          $(EPSFILES:.eps=.pdf) $(BZ2EPSFILES:.eps.bz2=.pdf)

all: $(TARGETS)

clean:
	$(RM) -f $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~

$(TREPSFILES): %.eps : tracks/%.eps
	cp $< $@

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	epstopdf -o=$@ $<

$(BZ2EPSFILES:.eps.bz2=.pdf): %.pdf: %.eps.bz2
	bzip2 -dkc $< | epstopdf -f -o=$@ 
