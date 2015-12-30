BASENAME:=pe14

all: build_ocaml build_racket

build_ocaml: $(BASENAME)_ocaml.ml
	ocamlopt -o $(BASENAME)_ocaml.native $(BASENAME)_ocaml.ml

build_racket: $(BASENAME)_racket.rkt
	raco make $(BASENAME)_racket.rkt

clean_racket:
	rm -rf compiled/*.zo compiled/*.dep

clean_ocaml:
	rm -rf *.o *.cmi *.cmx *.native

clean: clean_ocaml clean_racket
