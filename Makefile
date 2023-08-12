PREFIX ?= /usr
MANDIR ?= $(PREFIX)/share/man
DOCDIR ?= $(PREFIX)/share/doc/git-mux

all: man
	@echo Run \'make install\' to install git-mux for all users.

man: git-mux.1.md
	@mkdir -p man/man1
	@pandoc --standalone --to man $< --output man/man1/git-mux.1

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(MANDIR)/man1
	@mkdir -p $(DESTDIR)$(DOCDIR)
	@cp -p git-mux $(DESTDIR)$(PREFIX)/bin/git-mux
	@cp -p man/man1/git-mux.1 $(DESTDIR)$(MANDIR)/man1
	@cp -p README.md $(DESTDIR)$(DOCDIR)
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/git-mux
	@echo Install successful. Run \'make uninstall\' to uninstall git-mux.

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/git-mux
	@rm -rf $(DESTDIR)$(MANDIR)/man1/git-mux.1
	@rm -rf $(DESTDIR)$(DOCDIR)

.PHONY: all man install uninstall
