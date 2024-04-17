PROGRAM ?= git-mux
PREFIX ?= /usr
DOCPREFIX ?= $(PREFIX)/share/doc/$(PROGRAM)
MANDIR ?= man/man1

all: doc format lint
	printf "\nRun 'sudo make install' to install $(PROGRAM).\n"

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(PREFIX)/share/$(MANDIR)
	mkdir -p $(DESTDIR)$(DOCPREFIX)
	cp -p bin/$(PROGRAM) $(DESTDIR)$(PREFIX)/bin
	cp -p bin/$(MANDIR)/$(PROGRAM).1 $(DESTDIR)$(PREFIX)/share/$(MANDIR)
	cp -p README.md $(DESTDIR)$(DOCPREFIX)
	cp -p docs/MANUAL.md $(DESTDIR)$(DOCPREFIX)
	chmod 755 $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)
	printf "\nInstall successful. Run 'sudo make uninstall' to uninstall $(PROGRAM).\n"

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)
	rm -f $(DESTDIR)$(PREFIX)/share/$(MANDIR)/$(PROGRAM).1
	rm -rf $(DESTDIR)$(DOCPREFIX)

doc: docs/$(PROGRAM).1.txt
	mkdir -p bin/$(MANDIR)
	pandoc --standalone --from markdown-smart --to man --output bin/$(MANDIR)/$(PROGRAM).1 $<
	pandoc --from markdown-smart --to gfm $< --output docs/MANUAL.md
	sed -i 's%\*\$$%*\\$$%g' docs/MANUAL.md
	sed -i 's%\*\(ENVIRONMENT\)\*%[\1](#environment)%g' docs/MANUAL.md
	sed -i 's%^#%##%g' docs/MANUAL.md
	sed -i -e '1i # MANUAL\n' docs/MANUAL.md
	sed -i 's%\("User Manual"\)%\1 \\" x-release-please-version%' bin/$(MANDIR)/$(PROGRAM).1

# https://github.com/prettier/prettier
# https://github.com/mvdan/sh
# https://github.com/koalaman/shellcheck
# https://github.com/igorshubovych/markdownlint-cli
format:
	command -v prettier >/dev/null 2>&1 && \
		prettier --write --log-level warn {README,CONTRIBUTING,{docs,.github}/**/*}.{md,yml}
	command -v shfmt >/dev/null 2>&1 && \
		shfmt --posix --indent 4 --case-indent --write bin/$(PROGRAM)
	 command -v shellcheck >/dev/null 2>&1 && \
		shellcheck --format=diff bin/$(PROGRAM) | git apply --allow-empty
	command -v markdownlint >/dev/null 2>&1 && \
		markdownlint . --ignore CHANGELOG.md --fix >/dev/null 2>&1 || true

lint:
	command -v shellcheck >/dev/null 2>&1 && \
		shellcheck bin/$(PROGRAM)
	command -v markdownlint >/dev/null 2>&1 && \
		markdownlint . --ignore CHANGELOG.md --disable first-line-heading

changelog:
	# https://github.com/conventional-changelog/conventional-changelog
	conventional-changelog --preset conventionalcommits --infile CHANGELOG.md --same-file

.PHONY: all install uninstall lint format changelog
