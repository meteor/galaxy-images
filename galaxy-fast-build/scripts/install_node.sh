#!/bin/sh

set -e

# Install the right version of Node and add it to PATH
# for `node main.js` later
NODE_VERSION=$("$BUILD_SCRIPTS_DIR/select_node_version.sh")
export NODE_VERSION

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

case "$NODE_VERSION" in 
  "8.11.1")
    # Download the custom build that shipped with Meteor 1.6.1.1:
    # https://github.com/meteor/node/commits/v8.11.1-meteor
    NODE_URL="https://s3.amazonaws.com/com.meteor.jenkins/dev-bundle-node-129/node_Linux_x86_64_v8.11.1.tar.gz"
    ;;
  "14.21.4")
    NODE_URL="https://static.meteor.com/dev-bundle-node-os/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz"
    ;;
  *-rc.[0-9]*)
    NODE_URL="https://nodejs.org/download/rc/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz"
    ;;
  *)
    NODE_URL="https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz"
    ;;
esac

curl -sSL "$NODE_URL" | tar -xz -C /

export PATH="/node-v${NODE_VERSION}-linux-x64/bin:$PATH"
