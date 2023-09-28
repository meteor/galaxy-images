#!/bin/bash

set -e

# download installer script
curl -v https://install.meteor.com -o /tmp/install_meteor.sh

# https://github.com/jshimko/meteor-launchpad/issues/39
sed -i.bak "s/tar -xzf.*/tar -xf \"\$TARBALL_FILE\" -C \"\$INSTALL_TMPDIR\"/g" /tmp/install_meteor.sh

# Install Meteor
printf "\n[-] Installing the latest version of Meteor...\n\n"
sh /tmp/install_meteor.sh