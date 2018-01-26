#!/bin/bash

set -e

# Look up .node_version.txt in Meteor application bundle
# (available since 1.2), and return the numerical version
# number of node used to deploy this app. If the file is
# not found, return a default version that works with
# really old Meteor distribution.
# (More recent versions also make it available in star.json
# alongside the npm version, but we still read from the most
# compatible place.)

default="0.10.46"

if [ -f /app/bundle/.node_version.txt ]; then
  grep -oh '[0-9\.]*' /app/bundle/.node_version.txt
else
  echo "$default"
fi
