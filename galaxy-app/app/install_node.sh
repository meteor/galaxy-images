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

if [ "$NODE_VERSION" == "8.11.1" ]
then
    # Download the custom build that shipped with Meteor 1.6.1.1:
    # https://github.com/meteor/node/commits/v8.11.1-meteor
    NODE_URL="https://s3.amazonaws.com/com.meteor.jenkins/dev-bundle-node-129/node_Linux_x86_64_v8.11.1.tar.gz"
else
    NODE_URL="https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz"
fi

curl -sSL "$NODE_URL" | tar -xz -C /
