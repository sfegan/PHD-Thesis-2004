FIGFILES = param.fig twodim.fig threedim.fig
PSFILES = gt023886_ev2652.ps gt023886_ev2652_raw.ps gt023886_ev2652_ped.ps \
	   gt023886_ev2652_gain.ps gt023886_ev2652_clean.ps \
	   gt023886_ev2652_param.ps gt023886_ev2652_clean_color.ps \
	   gt023886_ev2652_param_color.ps
EPSFILES = crab_0_0_y0001_sig_bw.eps crab_0_3_y0001_sig_bw.eps \
	   crab_1_3_y0001_sig_bw.eps sigma_center.eps sigma.eps \
	   dof_exp_like_0_348.eps dof_exp_like_0_550.eps \
	   dof_exp_like_1_100.eps dof_like.eps rate_model.eps 

TARGETS = $(FIGFILES:.fig=.pdf) $(EPSFILES:.eps=.pdf) $(PSFILES:.ps=.pdf)

all: $(TARGETS)

clean:
	$(RM) -f $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~ 

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(PSFILES:.ps=.pdf): %.pdf: %.ps
	epstopdf -o=$@ $<

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	epstopdf -o=$@ $<
