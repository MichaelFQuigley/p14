BASENAME:=pe14

all: build_ocaml build_racket build_bash build_c build_rust

build_bash:
	chmod 775 $(BASENAME)_bash.sh

build_ocaml: $(BASENAME)_ocaml.ml
	ocamlopt -o $(BASENAME)_ocaml.native $(BASENAME)_ocaml.ml

build_c: $(BASENAME)_c.c
	gcc -std=gnu99 -pthread -O2 $(BASENAME)_c.c -o $(BASENAME)_c.out -lrt

build_racket: $(BASENAME)_racket.rkt
	raco make $(BASENAME)_racket.rkt

build_rust: $(BASENAME)_rust.rs
	rustc $(BASENAME)_rust.rs

clean_rust:
	rm $(BASENAME)_rust

clean_racket:
	rm -rf compiled/*.zo compiled/*.dep

clean_ocaml:
	rm -rf *.cmi *.cmx *.native *.out *.o

clean: clean_ocaml clean_racket clean_rust
