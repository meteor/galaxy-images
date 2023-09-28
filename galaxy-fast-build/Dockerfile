FROM meteor/ubuntu:20210720

# Update packages and install necessary dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    jq \
    # Clean up to reduce image size
    rm -rf /var/lib/apt/lists/*

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

ENV BUILD_SCRIPTS_DIR=/opt/build_scripts \
    APP_SOURCE_FOLDER=/opt/meteor/src \
    APP_BUNDLE_FOLDER=/opt/meteor/dist \
    METEOR_ALLOW_SUPERUSER=true

# Install Meteor
RUN $BUILD_SCRIPTS_DIR/install_meteor.sh
ENV PATH="/root/.meteor:${PATH}"