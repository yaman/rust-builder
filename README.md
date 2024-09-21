# 🦀 Rust Nightly Development Docker Image 🐳

## 🚀 Features

This Docker image provides a powerful Rust development environment based on the nightly Rust toolchain. It comes pre-loaded with essential tools and utilities to supercharge your Rust projects!

### 🛠️ Included Tools

- 🦀 Rust Nightly Toolchain
- 🔧 CMake
- 📦 cargo-binstall
- 🧰 Additional Cargo Tools:
  - 🧪 cargo-nextest: Modern, fast test runner
  - 🛡️ cargo-tarpaulin: Code coverage tool
  - 📊 cargo-criterion: Statistics-driven benchmarking
  - 🔍 cargo-llvm-cov: LLVM-based code coverage

### 🔧 Rust Components

- 📝 rustfmt: Code formatter
- 🔬 clippy: Linter

## 🚀 Usage

1. Pull the image:

    ```bash
    docker pull yamah/rust-builder:latest
    ```

2. Run a container:

    ```bash
    docker run -it --rm yamah/rust-builder:latest
    ```

3. Start coding with all the tools at your fingertips!

## 🛠️ Building the Image

To build the image yourself:

```bash
docker build -t rust-builder .
```

## 🤝 Contributing

We welcome contributions! Please open an issue or submit a PR.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

Happy Rust coding! 🦀✨
