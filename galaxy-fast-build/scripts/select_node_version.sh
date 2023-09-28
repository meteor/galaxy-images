#!/bin/bash

set -e

# Define the path to the star.json and the default Node version
meteor_star_json="${APP_BUNDLE_FOLDER}/bundle/star.json"
default="0.10.46"

# Define a function to get the desired version from star.json
get_desired_version() {
  if [ -f "${meteor_star_json}" ]; then
    jq -r '.nodeVersion | select (.!=null)' "${meteor_star_json}"
  else
    echo ""
  fi
}

desired_version=$(get_desired_version)

# If we got a version from star.json, output it and exit
if [ -n "${desired_version}" ]; then
  echo "${desired_version}"
  exit 0
fi

# Fall back to the .node_version.txt file if star.json didn't provide a version
node_version_file="${APP_BUNDLE_FOLDER}/bundle/.node_version.txt"
if [ -f "${node_version_file}" ]; then
  grep -oh '[0-9][0-9\.]*\(-\S*\)\?' "${node_version_file}"
  exit 0
fi

# If neither file provided a version, output the default
echo "$default"
