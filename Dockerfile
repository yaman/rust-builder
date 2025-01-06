FROM ubuntu:rolling

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    cmake \
    pkg-config \
    libssl-dev \
    ca-certificates \
    build-essential \
    unzip \
    perl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Update CA certificates
RUN update-ca-certificates

# Install Rust toolchain globally
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- -y --default-toolchain nightly --no-modify-path && \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME

# Add rustfmt and clippy components
RUN rustup component add rustfmt clippy

# Install cargo-binstall
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

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
