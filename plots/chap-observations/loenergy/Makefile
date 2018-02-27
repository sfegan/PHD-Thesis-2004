FIGFILES = 
EPSFILES = J1826-1302_guide_bw.eps \
           J2021+3716_guide_bw.eps
BZ2EPSFILES = J0010+7309_sul_conv_bw.eps.bz2 \
              J0241+6103_sul_conv_bw.eps.bz2 \
              J0423+1707_sul_conv_bw.eps.bz2 \
              J0433+2908_sul_conv_bw.eps.bz2 \
              J0450+1105_sul_conv_bw.eps.bz2 \
              J0613+4201_sul_conv_bw.eps.bz2 \
              J0628+1847_sul_conv_bw.eps.bz2 \
              J0634+0521_sul_conv_bw.eps.bz2 \
              J1009+4855_sul_conv_bw.eps.bz2 \
              J1323+2200_sul_conv_bw.eps.bz2 \
              J1337+5029_sul_conv_bw.eps.bz2 \
              J1337+5029_sigma_conv_bw.eps.bz2 \
              J1826-1302_sul_conv_bw.eps.bz2 \
              J1835+5918_sul_conv_bw.eps.bz2 \
              J1907+0557_sul_conv_bw.eps.bz2 \
              J2021+3716_sul_conv_bw.eps.bz2 \
              J2227+6122_sigma_conv_bw.eps.bz2 \
              J2227+6122_sul_conv_bw.eps.bz2 \
              J2248+1745_sul_conv_bw.eps.bz2 \
              J2255+1943_sul_conv_bw.eps.bz2

TARGETS = $(BZ2EPSFILES:.eps.bz2=.pdf) $(EPSFILES:.eps=.pdf) $(FIGFILES:.fig=.pdf) 

all: $(TARGETS)

clean:
	$(RM) $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(BZ2EPSFILES:.eps.bz2=.pdf): %.pdf: %.eps.bz2
	bzip2 -dkc $< | sed -e '/%%BoundingBox/s/-39/6/' | epstopdf -f -o=$@ 

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	sed -e '/%%BoundingBox/s/-39/6/' $< | epstopdf -f -o=$@ 
