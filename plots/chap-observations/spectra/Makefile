FIGFILES = 
EPSFILES = 3EG_J0010+7309.eps 3EG_J0010+7309_int.eps \
           3EG_J0241+6103.eps 3EG_J0241+6103_int.eps \
           3EG_J0423+1707.eps 3EG_J0423+1707_int.eps \
           3EG_J0433+2908.eps 3EG_J0433+2908_int.eps \
           3EG_J0450+1105.eps 3EG_J0450+1105_int.eps \
           3EG_J0613+4201.eps 3EG_J0613+4201_int.eps \
           3EG_J0628+1847.eps 3EG_J0628+1847_int.eps \
	   3EG_J0631+0642.eps 3EG_J0631+0642_int.eps \
	   3EG_J0634+0521.eps 3EG_J0634+0521_int.eps \
           3EG_J1009+4855.eps 3EG_J1009+4855_int.eps \
           3EG_J1323+2200.eps 3EG_J1323+2200_int.eps \
           3EG_J1337+5029.eps 3EG_J1337+5029_int.eps \
           3EG_J1823-1314.eps 3EG_J1826-1302_int.eps \
           3EG_J1826-1302.eps 3EG_J1826-1302_int.eps \
           3EG_J1835+5918.eps 3EG_J1835+5918_int.eps \
           3EG_J2021+3716.eps 3EG_J2021+3716_int.eps \
           3EG_J2016+3657.eps 3EG_J2016+3657_int.eps \
           3EG_J2227+6122.eps 3EG_J2227+6122_int.eps \
           3EG_J2248+1745.eps 3EG_J2248+1745_int.eps \
           3EG_J2255+1943.eps 3EG_J2255+1943_int.eps

TARGETS = $(EPSFILES:.eps=.pdf) $(FIGFILES:.fig=.pdf) 

all: $(TARGETS)

clean:
	$(RM) $(TARGETS) $(FIGFILES:.fig=.fig.bak) *~

$(FIGFILES:.fig=.pdf): %.pdf: %.fig
	fig2dev -Lpdf $< $@

$(EPSFILES:.eps=.pdf): %.pdf: %.eps
	epstopdf -o=$@ $<
