#!/bin/bash

set -e

if [ -z "$NODE_VERSION" ]; then
  echo "NODE_VERSION is not set." >&2
  exit 1
fi

if [ -d "/node-v${NODE_VERSION}-linux-x64" ]; then
  echo "node version ${NODE_VERSION} already installed."
  exit 0
fi

echo "Installing node version ${NODE_VERSION} to /node-v${NODE_VERSION}-linux-x64"

set -x

curl -sSLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C / \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz"
