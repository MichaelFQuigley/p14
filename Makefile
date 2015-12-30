ocaml:
	ocamlopt -o pe14_ocaml.native pe14.ml

clean:
	rm -rf *.o *.cmi *.cmx *.native
