BASENAME:=pe14

all: build_ocaml

build_ocaml: $(BASENAME)_ocaml.ml
	ocamlopt -o $(BASENAME)_ocaml.native $(BASENAME)_ocaml.ml

clean_ocaml:
	rm -rf *.o *.cmi *.cmx *.native

clean: clean_ocaml
