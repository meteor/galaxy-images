#!/bin/bash

set -e

# download installer script
curl -v https://install.meteor.com -o /tmp/install_meteor.sh

# read in the release version in the app
METEOR_VERSION=$(head $APP_SOURCE_FOLDER/.meteor/release | cut -d "@" -f 2)

# set the release version in the install script
sed -i.bak "s/RELEASE=.*/RELEASE=\"$METEOR_VERSION\"/g" /tmp/install_meteor.sh

# replace tar command with bsdtar in the install script (bsdtar -xf "$TARBALL_FILE" -C "$INSTALL_TMPDIR")
# https://github.com/jshimko/meteor-launchpad/issues/39
sed -i.bak "s/tar -xzf.*/tar -xf \"\$TARBALL_FILE\" -C \"\$INSTALL_TMPDIR\"/g" /tmp/install_meteor.sh

# install
printf "\n[-] Installing Meteor $METEOR_VERSION...\n\n"
sh /tmp/install_meteor.sh

echo "export PATH=$PATH:/home/mt/.meteor" >> /home/mt/.bashrc