#!/bin/sh
#
# Adapted from:
# <https://github.com/libra/libra/blob/master/validator-sets/build.sh>
#
# Copyright (c) The Libra Core Contributors
# SPDX-License-Identifier: Apache-2.0

set -eux

NETWORK_NAME="devnet-0"
OUTDIR="validator-sets/$NETWORK_NAME"
NUM_NODES=4

git submodule update --init

mkdir -p "$OUTDIR"

if [ ! -e "$OUTDIR/mint.key" ]; then
  cd libra
	cargo run --bin generate-keypair -- -o "../$OUTDIR/mint.key"
	cd -
fi

cd libra
cargo run --bin libra-config -- -b ../node.config.toml -m "../$OUTDIR/mint.key" -o "../$OUTDIR" -d -n $NUM_NODES
cd -

cd "$OUTDIR"

# Remove all generated node.config.toml files.
find . -mindepth 2 -iname node.config.toml | xargs rm
# Move all keys files to single top-level directory.
find . -mindepth 2 -iname '*.keys.toml' | xargs -I '{}' mv '{}' ./
# Move all seed peers files to top-level directory.
find . -mindepth 2 -iname '*.seed_peers.config.toml' | xargs rm
# Move all network peers files to top-level directory.
find . -mindepth 2 -iname '*.network_peers.config.toml' -exec mv -f {} ./network_peers.config.toml \;
# Move all consensus peers files to top-level directory.
find . -mindepth 2 -iname 'consensus_peers.config.toml' -exec mv -f {} ./consensus_peers.config.toml \;
# Move all genesis.blob files to top-level directory.
find . -mindepth 2 -iname 'genesis.blob' -exec mv -f {} ./genesis.blob \;
# Delete all directories.
find . -mindepth 1 -type d | xargs rmdir

cd -
