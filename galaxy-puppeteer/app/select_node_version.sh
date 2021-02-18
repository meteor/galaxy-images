#!/bin/bash

set -e

# Look up nodeVersion from the Meteor application star.json (available
# since 1.5.2/1.6). If the value is not found, return a default version
# that works for older versions too.

meteor_star_json="/app/bundle/star.json"
default="0.10.46"

get_desired_version() {
  if [ -f "${meteor_star_json}" ]; then
    jq -r '.nodeVersion | select (.!=null)' "${meteor_star_json}"
  fi
}

desired_version=$(get_desired_version)

if [ -n "${desired_version}" ]; then
  echo "${desired_version}"
  exit 0
fi

# Fall back to the .node_version.txt file if start.json didn't work.
if [ -f /app/bundle/.node_version.txt ]; then
  grep -oh '[0-9][0-9\.]*\(-\S*\)\?' /app/bundle/.node_version.txt
  exit 0
fi

echo "$default"
