TARGETS=chap-introduction chap-sources chap-technique chap-analysis \
        chap-observations chap-veritas app-ellipt app-smoothing \
	app-liandma
CLEANTARGETS=$(addprefix clean-,$(TARGETS))

all: $(TARGETS)

$(TARGETS) :
	$(MAKE) -C $@

clean: $(CLEANTARGETS)

$(CLEANTARGETS):
	$(MAKE) -C $(subst clean-,,$@) clean

.PHONY: all $(TARGETS) clean $(CLEANTARGETS)
