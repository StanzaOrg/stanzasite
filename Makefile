
STANZA=stanza

.PHONY: all
all: site book

generated:
	mkdir generated

bin/site: stanza.proj
	${STANZA} build

.PHONY: site
site: generated bin/site
	bin/site site

.PHONY: book
book: generated bin/site
	bin/site book

.PHONY: clean
clean:
	rm -rf generated bin/site

