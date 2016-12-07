#!/bin/bash

set -ex

function build_dev() {
  cargo build --manifest-path rust/Cargo.toml
  mkdir -p bin
  crystal build src/main.cr -o bin/main-dev \
    --link-flags ${PWD}/rust/target/debug/libperson.a
}

function build_release() {
  cargo build --release --manifest-path rust/Cargo.toml
  mkdir -p bin
  crystal build --release src/main.cr -o bin/main-dev \
    --link-flags ${PWD}/rust/target/release/libperson.a
}

function clean() {
  cargo clean --manifest-path rust/Cargo.toml
  rm -rf bin
}

case "$1" in
  "release" ) build_release;;
  "clean" ) clean;;
  * ) build_dev;;
esac

