FIGFILES = vscope-base.fig varray-base.fig vreconstruct-3d.fig \
           vshower-param.fig vreconstruct2.fig
EPSFILES = AngularAcceptanceColor.eps AngularErrorColor.eps \
           DifferentialRateColor.eps InterpolationCollectionAreaColor.eps \
           ProtonDifferentialRateColor.eps ProtonSuppressionFactorColorBB.eps \
           Sensitivity50and5Color.eps TriggerRateColor.eps \
           V7ApertureCollectionAreaColor.eps  \
	   V7MeshCollectionAreaColor.eps V7CollectionAreaColor.eps \
           recpicture1.eps recpicture2.eps

TARGETS = $(FIGFILES:.fig=.pdf) $(EPSFILES:.eps=.pdf)

all: $(TARGETS)

clean:
	$(RM) -f $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~ \
		ProtonSuppressionFactorColorBB.eps

ProtonSuppressionFactorColorBB.eps: ProtonSuppressionFactorColor.eps
	sed -e '/BoundingBox/s/80/59/' $< > $@

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	epstopdf -o=$@ $<
