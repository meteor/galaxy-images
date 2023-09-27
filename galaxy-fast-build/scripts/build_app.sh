#!/bin/bash

#
# builds a production meteor bundle directory
#
set -e

# set up npm auth token if one is provided
if [[ "$NPM_TOKEN" ]]; then
  echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc
fi

cd $APP_SOURCE_FOLDER

# Install app deps
printf "\n[-] Running npm install in app directory...\n\n"
# Check if METEOR_VERSION starts with 1.6
if [[ "${METEOR_VERSION}" == 1.6* ]]; then
    meteor npm install --verbose
else
    meteor npm ci --verbose
fi

# build the bundle
printf "\n[-] Building Meteor application...\n\n"
meteor build --directory $APP_BUNDLE_FOLDER --server-only

if [ -f "/${APP_BUNDLE_FOLDER}/bundle/programs/server/assets/app/p2d-enabled.galaxy" ]; then
  export METEOR_SKIP_NPM_REBUILD=1
fi
# run npm install in bundle
printf "\n[-] Running npm install in the server bundle...\n\n"
cd $APP_BUNDLE_FOLDER/bundle/programs/server/
meteor npm install --production --verbose