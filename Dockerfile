FROM debian:latest

RUN apt update && apt install -y curl cmake openssl libssl-dev pkg-config

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly -y

RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

RUN rustup component add rustfmt clippy

RUN cargo binstall cargo-nextest cargo-tarpaulin cargo-criterion cargo-llvm-cov sccache -y
