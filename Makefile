MANDIR = bin/man/man1

git-mux.1: docs/git-mux.1.md
	mkdir -p ${MANDIR}
	pandoc -s -w man $< -o ${MANDIR}/$@

