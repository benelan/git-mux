PROGRAM ?= git-mux
PREFIX ?= /usr
MANDIR ?= man/man1
DOCDIR ?= $(PREFIX)/share/doc/$(PROGRAM)

all: man
	@echo Run \'make install\' to install $(PROGRAM).

man: $(PROGRAM).1.txt
	@mkdir -p $(MANDIR)
	@pandoc --standalone --from markdown-smart --to man $< --output $(MANDIR)/$(PROGRAM).1

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(PREFIX)/share/$(MANDIR)
	@mkdir -p $(DESTDIR)$(DOCDIR)
	@cp -p $(PROGRAM) $(DESTDIR)$(PREFIX)/bin
	@cp -p $(MANDIR)/$(PROGRAM).1 $(DESTDIR)$(PREFIX)/share/$(MANDIR)
	@cp -p README.md $(DESTDIR)$(DOCDIR)
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)
	@echo Install successful. Run \'make uninstall\' to uninstall $(PROGRAM).

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)
	@rm -rf $(DESTDIR)$(PREFIX)/share/$(MANDIR)/$(PROGRAM).1
	@rm -rf $(DESTDIR)$(DOCDIR)

.PHONY: all man install uninstall
