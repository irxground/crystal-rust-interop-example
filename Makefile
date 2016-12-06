# vim: noexpandtab tabstop=4 shiftwidth=4

.PHONY: build
build : bin/main-dev

.PHONY: release
release : bin/main-release

.PHONY: clean
clean :
	rm -rf bin
	cd rust && cargo clean

bin/main-dev : src/main.cr rust/target/debug/libperson.a
	mkdir -p bin
	crystal build src/main.cr -o $@ \
		--link-flags ${PWD}/rust/target/debug/libperson.a

bin/main-release : src/main.cr rust/target/release/libperson.a
	mkdir -p bin
	crystal build --release src/main.cr -o $@ \
		--link-flags ${PWD}/rust/target/release/libperson.a

rust/target/debug/libperson.a :
	cd rust && cargo build

rust/target/release/libperson.a :
	cd rust && cargo build --release
