ocaml:
	ocamlopt -o pe14_ocaml.native pe14_ocaml.ml

clean:
	rm -rf *.o *.cmi *.cmx *.native
