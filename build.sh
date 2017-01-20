#!/bin/bash

set -Ceu

function build_dev() {
  set -x
  cargo build --manifest-path rust/Cargo.toml
  mkdir -p bin-debug
  crystal build src/main.cr -o bin-debug/main \
    --link-flags ${PWD}/rust/target/debug/libperson.a
}

function build_release() {
  set -x
  cargo build --release --manifest-path rust/Cargo.toml
  mkdir -p bin
  crystal build --release src/main.cr -o bin/main \
    --link-flags ${PWD}/rust/target/release/libperson.a
}

function clean() {
  set -x
  cargo clean --manifest-path rust/Cargo.toml
  rm -rf bin-debug
  rm -rf bin
}

case "${1-debug}" in
  "release" ) build_release;;
  "clean" ) clean;;
  "debug" ) build_dev;;
esac

