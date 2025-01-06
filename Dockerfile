FROM rustlang/rust:nightly-alpine

# Install required dependencies
RUN apk add --no-cache \
    curl \
    cmake \
    openssl \
    openssl-dev \
    pkgconfig \
    ca-certificates \
    unzip \
    gcc \
    musl-dev \
    libc-dev \
    make \
    bash \
    perl

# Update CA certificates
RUN update-ca-certificates

# Install cargo-binstall
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

# Add rustfmt and clippy components
RUN rustup component add rustfmt clippy

# Install cargo tools
RUN cargo binstall cargo-nextest cargo-tarpaulin cargo-criterion cargo-llvm-cov sccache -y

# Install AWS CLI based on architecture
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    elif [ "$ARCH" = "aarch64" ]; then \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"; \
    else \
    echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip
