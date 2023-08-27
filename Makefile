PROGRAM ?= git-mux
PREFIX ?= /usr
DOCPREFIX ?= $(PREFIX)/share/doc/$(PROGRAM)
MANDIR ?= man/man1

all: man
	@echo Run \'make install\' to install $(PROGRAM).

man: $(PROGRAM).1.txt
	@mkdir -p $(MANDIR)
	@pandoc --standalone --from markdown-smart --to man $< --output $(MANDIR)/$(PROGRAM).1
	@pandoc --standalone --from markdown-smart --to gfm $< --output MANUAL.md
	@sed -i 's%\*\$$%*\\$$%g' MANUAL.md
	@sed -i 's%\*ENVIRONMENT\*%[ENVIRONMENT](#environment)%g' MANUAL.md
	@sed -i 's%^#%##%g' MANUAL.md

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(PREFIX)/share/$(MANDIR)
	@mkdir -p $(DESTDIR)$(DOCPREFIX)
	@cp -p $(PROGRAM) $(DESTDIR)$(PREFIX)/bin
	@cp -p $(MANDIR)/$(PROGRAM).1 $(DESTDIR)$(PREFIX)/share/$(MANDIR)
	@cp -p README.md $(DESTDIR)$(DOCPREFIX)
	@cp -p MANUAL.md $(DESTDIR)$(DOCPREFIX)
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)
	@echo Install successful. Run \'make uninstall\' to uninstall $(PROGRAM).

uninstall:
	@rm -f $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)
	@rm -f $(DESTDIR)$(PREFIX)/share/$(MANDIR)/$(PROGRAM).1
	@rm -rf $(DESTDIR)$(DOCPREFIX)

.PHONY: all install uninstall
