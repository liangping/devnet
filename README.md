# OpenLibra Testnet

This directory contains a *work-in-progress* builder for an OpenLibra testnet
based on the upstream Libra testnet configuration builder:

<https://github.com/libra/libra/tree/master/terraform/validator-sets>

## Prerequisites

- Rust **1.38**: <https://rustup.rs/>

## Usage

You can run the work-in-progress testnet builder with the following:

```
./build.sh
```

Presently it will build a set of files in `validator-sets/`.
This directory is in `.gitignore` until we have the script fully working and
are ready to check in the resulting output.
