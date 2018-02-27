FIGFILES = arrival_direction.fig estimateBySize+dist09.fig \
           fits2.fig fits4.fig chisq.fig ellipt.fig long+gauss.fig trans.fig 
EPSFILES = 
           

TARGETS = $(FIGFILES:.fig=.pdf) $(EPSFILES:.eps=.pdf) $(EPSFILES:.fig=.pdf)

all: $(TARGETS)

clean:
	$(RM) -f $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~ 

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(EPSFILES:.fig=.pdf): %.pdf: %.fig
	epstopdf -o=$@ $<

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	epstopdf -o=$@ $<
