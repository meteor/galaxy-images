FROM meteor/ubuntu:20210720

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]
# Make sure we have jq to parse star.json to choose the npm version.
RUN apt-get update && \
    apt-get install --no-install-recommends -y jq && \
    rm -rf /var/lib/apt/lists/*

ENV BUILD_SCRIPTS_DIR=/opt/build_scripts \
    APP_SOURCE_FOLDER=/opt/meteor/src \
    APP_BUNDLE_FOLDER=/opt/meteor/dist \
    METEOR_ALLOW_SUPERUSER=true

# Add entrypoint and build scripts
COPY ./scripts $BUILD_SCRIPTS_DIR

# Install Meteor
RUN $BUILD_SCRIPTS_DIR/install_meteor.sh
ENV PATH="/root/.meteor:${PATH}"