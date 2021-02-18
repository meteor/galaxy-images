#!/bin/bash
set -e

# Look up npmVersion from the Meteor application star.json
# (available since 1.5.2/1.6).  If the value is not found,
# return a default version that works for older versions too.
# For compatibility with Node 0.10.x (Meteor 1.3 and earlier),
# we've chosen to go with npm 4.5.0, which should be good for all
# versions on the Meteor 1.4 and 1.5 series as well.

meteor_star_json="/app/bundle/star.json"
default="4.5.0"

get_desired_version() {
  if [ -f "${meteor_star_json}" ]; then
    jq -r '.npmVersion | select (.!=null)' "${meteor_star_json}"
  fi
}

desired_version=$(get_desired_version)

if [ -n "${desired_version}" ]; then
  echo "${desired_version}"
else
  echo "$default"
fi
