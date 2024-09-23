FROM rustlang/rust:nightly

RUN apt update && apt install -y curl cmake

RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

RUN rustup component add rustfmt clippy
RUN cargo binstall cargo-nextest cargo-tarpaulin cargo-criterion cargo-llvm-cov -y
