#!/bin/sh

set -e

# Download the Meteor installation script
curl -v https://install.meteor.com -o /tmp/install_meteor.sh

# Replace the tar command with bsdtar in the installation script
# https://github.com/jshimko/meteor-launchpad/issues/39
sed -i.bak "s/tar -xzf.*/tar -xf \"\$TARBALL_FILE\" -C \"\$INSTALL_TMPDIR\"/g" /tmp/install_meteor.sh

# Install Meteor
printf "\n[-] Installing the latest version of Meteor...\n\n"
sh /tmp/install_meteor.sh

# Update the PATH
echo "export PATH=$PATH:/home/mt/.meteor" >> /home/mt/.ashrc
