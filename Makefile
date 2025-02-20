PROGRAM = git-mux

# variables for installation directories, see:
# https://www.gnu.org/software/make/manual/html_node/Directory-Variables.html
PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
DATAROOTDIR ?= $(PREFIX)/share
DOCDIR ?= $(DATAROOTDIR)/doc/$(PROGRAM)
MANDIR ?= $(DATAROOTDIR)/man
MAN1DIR ?= $(MANDIR)/man1

# variables for local project files
BINFILE = bin/$(PROGRAM)
MANFILE = bin/man/man1/$(PROGRAM).1
DOCFILE = docs/MANUAL.md

all: doc format lint
	printf "\nRun 'sudo make install' to install $(PROGRAM).\n"

install: $(BINFILE) $(MANFILE)
	mkdir -p $(DESTDIR)$(BINDIR) $(DESTDIR)$(MAN1DIR) $(DESTDIR)$(DOCDIR)
	cp -p $(BINFILE) $(DESTDIR)$(BINDIR)
	cp -p $(MANFILE) $(DESTDIR)$(MAN1DIR)
	cp -p $(DOCFILE) $(DESTDIR)$(DOCDIR)
	cp -p README.md $(DESTDIR)$(DOCDIR)
	chmod 755 $(DESTDIR)$(BINDIR)/$(PROGRAM)
	printf "\nInstall successful. Run 'sudo make uninstall' to uninstall $(PROGRAM).\n"

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(PROGRAM)
	rm -f $(DESTDIR)$(MAN1DIR)/$(PROGRAM).1
	rm -rf $(DESTDIR)$(DOCDIR)

doc: docs/$(PROGRAM).1.txt
	mkdir -p bin/man/man1
	pandoc --standalone --from markdown-smart --to man --output $(MANFILE) $<
	pandoc --standalone --from markdown-smart --to gfm --output $(DOCFILE) $<
	sed -i 's%\*\$$%*\\$$%g' $(DOCFILE)
	sed -i 's%\*\(ENVIRONMENT\)\*%[\1](#environment)%g' $(DOCFILE)
	sed -i 's%^#%##%g' $(DOCFILE)
	sed -i -e '1i # MANUAL\n' $(DOCFILE)
	sed -i 's%\("User Manual"\)%\1 \\" x-release-please-version%' $(MANFILE)

# https://github.com/prettier/prettier
# https://github.com/mvdan/sh
# https://github.com/koalaman/shellcheck
# https://github.com/igorshubovych/markdownlint-cli
format:
	command -v prettier >/dev/null 2>&1 && \
		prettier --write --log-level warn {README,CONTRIBUTING,{docs,.github}/**/*}.{md,yml}
	command -v shfmt >/dev/null 2>&1 && \
		shfmt --posix --indent 4 --case-indent --write $(BINFILE)
	command -v shellcheck >/dev/null 2>&1 && \
		shellcheck --format=diff $(BINFILE) | git apply --allow-empty
	command -v markdownlint >/dev/null 2>&1 && \
		markdownlint . --ignore CHANGELOG.md --fix >/dev/null 2>&1 || true

lint:
	command -v shellcheck >/dev/null 2>&1 && shellcheck $(BINFILE)
	command -v markdownlint >/dev/null 2>&1 && markdownlint . --ignore CHANGELOG.md

# https://github.com/conventional-changelog/conventional-changelog
changelog:
	conventional-changelog --preset conventionalcommits --infile CHANGELOG.md --same-file

.PHONY: all install uninstall doc lint format changelog
