#!/bin/bash

set -e

export NODE_VERSION
NODE_VERSION=$(/app/select_node_version.sh)
export PATH="/node-v${NODE_VERSION}-linux-x64/bin:$PATH"

cd /app/bundle

if [ -x run.sh ]; then
  # In theory let people configure their runtime by including run.sh in the
  # bundle (but Meteor doesn't actually provide a way to do this).
  exec bash run.sh
else
  # Allow users to specify options to pass to Node via $GALAXY_NODE_OPTIONS env
  # var or the deprecated $NODE_OPTIONS env var, which may contain spaces to
  # pass multiple options.  There's no easy way to allow a single env var to
  # contain multiple options and still allow some of them to contain whitespace;
  # for anything along those lines, use a custom base image.
  #
  # We originally used NODE_OPTIONS for this purpose but Node 8 added direct
  # support for a variable of the same name which does something similar but
  # disallows many options such as V8 options.  You can still use NODE_OPTIONS
  # if you want to use one of Node's whitelisted options, but
  # GALAXY_NODE_OPTIONS will work for all Node options.
  # shellcheck disable=SC2086
  exec node ${GALAXY_NODE_OPTIONS:-} ${NODE_OPTIONS:-} main.js
fi
