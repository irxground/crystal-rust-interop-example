# vim: noexpandtab tabstop=4 shiftwidth=4

.PHONY: build
build: bin/main

.PHONY: clean
clean:
	rm -rf bin
	cd rust && cargo clean

bin:
	mkdir -p bin

bin/main: bin src/main.cr rust/target/debug/libperson.a
	crystal src/main.cr -o bin/main --link-flags ${PWD}/rust/target/debug/libperson.a

rust/target/debug/libperson.a:
	cd rust && cargo build
