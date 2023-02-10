#!/usr/bin/env bash

CACHE_DIR=".cache"
NOIR_REPO_CACHE="$CACHE_DIR/noir"
GIT_VENDOR_URL="https://github.com"
NOIR_REPO_PATH="noir-lang/noir"
NOIR_CLONE_URL="$GIT_VENDOR_URL/$NOIR_REPO_PATH.git"
NOIR_BUILD="./.build"
main_dir=$(pwd)

rm -rf "$NOIR_BUILD"

mkdir -p "$NOIR_BUILD"

if [[ -d "$NOIR_REPO_CACHE" ]]; then
    echo "$NOIR_REPO_CACHE exists on your filesystem, using it for build..."
else
    echo "$NOIR_REPO_CACHE does not exists on your filesystem, clonning from $NOIR_CLONE_URL"
    git clone $NOIR_CLONE_URL $NOIR_REPO_CACHE
    # git checkout ae93368436acf3f5147a1cf9e6ad0d755ed04646
fi

cp -a "$NOIR_REPO_CACHE/." "$NOIR_BUILD/"

cd "$NOIR_BUILD/crates/wasm"

./build-wasm
cd $main_dir

rm -rf ./nodejs
rm -rf ./web
rm package.json

cp -a "$NOIR_BUILD/crates/wasm/pkg/nodejs/." ./nodejs
cp -a "$NOIR_BUILD/crates/wasm/pkg/web/." ./web
cp "$NOIR_BUILD/crates/wasm/pkg/package.json" ./

cd $NOIR_BUILD
NOIR_REV=$(git rev-parse HEAD)
NOIR_REV_SHORT=$(git rev-parse --short HEAD)

cd $main_dir
sed -i -E "s/\[noir-lang\/noir@.+\]\(.+\)/\[noir-lang\/noir@$NOIR_REV_SHORT\](https:\/\/github.com\/noir-lang\/noir\/tree\/$NOIR_REV)/g" ./README.md

cat ./package.json | jq '.repository = { "type" : "git", "url" : "https://github.com/noir-lang/noir_wasm.git" }' | jq ".compiler = { \"versionHash\" : \"$NOIR_REV\" }" | tee ./package.json