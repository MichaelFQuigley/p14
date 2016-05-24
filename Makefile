BASENAME:=pe14

all: build_ocaml build_racket build_bash build_c build_rust build_haskell build_swift build_java

build_bash: $(BASENAME)_bash.sh
	chmod 775 $(BASENAME)_bash.sh

build_c: $(BASENAME)_c.c
	gcc -std=gnu99 -pthread -O2 $(BASENAME)_c.c -o $(BASENAME)_c.out -lrt

build_haskell: $(BASENAME)_haskell.hs
	ghc -O2 $(BASENAME)_haskell.hs

build_java: $(BASENAME)_java.java
	javac -d javasrc/ $(BASENAME)_java.java

build_ocaml: $(BASENAME)_ocaml.ml
	ocamlopt -o $(BASENAME)_ocaml.native $(BASENAME)_ocaml.ml

build_racket: $(BASENAME)_racket.rkt
	raco make $(BASENAME)_racket.rkt

build_rust: $(BASENAME)_rust.rs
	rustc $(BASENAME)_rust.rs

build_swift: $(BASENAME)_swift.swift
	swiftc $(BASENAME)_swift.swift -o $(BASENAME)_swift.o

clean_objs:
	rm $(BASENAME)_rust $(BASENAME)_haskell

clean_racket:
	rm -rf compiled/*.zo compiled/*.dep

clean_ocaml:
	rm -rf *.cmi *.cmx *.native *.out *.o

clean_java:
	rm -rf javasrc/*

clean: clean_ocaml clean_racket clean_objs
