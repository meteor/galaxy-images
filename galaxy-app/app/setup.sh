#!/bin/bash

set -ex

# Download and untar bundle. Don't use timestamps from the deployer's computer:
# if their clock is in the future, this can seriously confuse build systems like
# make.
cd /app && curl -sS "$1" | tar xz -m
cd /app/bundle

# Install right version of Node and add it to PATH
# for `npm install` later
export NODE_VERSION
NODE_VERSION=$(/app/select_node_version.sh)
/app/install_node.sh
export PATH="/node-v${NODE_VERSION}-linux-x64/bin:$PATH"

# Install the desired version of npm, if we know what it is, otherwise
# install a default version.
npm_version=$(/app/select_npm_version.sh)
npm -g install npm@"${npm_version}"

# NPM install
pushd programs/server
# Pass --unsafe-perm in order to still run scripts even though we run as root.
npm install --unsafe-perm

# Run custom setup.sh in programs/server if provided, as ROOT.
if [ -x ./setup.sh ]; then
  bash ./setup.sh
fi
popd

# Run custom setup.sh in bundle if provided, as ROOT.
if [ -x ./setup.sh ]; then
  bash ./setup.sh
fi
