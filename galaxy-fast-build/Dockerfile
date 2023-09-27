FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
# Note: 'python-is-python2' is not available in Debian Bullseye. Instead, we use 'python2'.
RUN apt-get update && \
    apt-get install -y --no-install-recommends jq curl ca-certificates python2 rsync \
      libssl-dev wget build-essential git && \
    rm -rf /var/lib/apt/lists/*

# Set python2 as the default python
RUN ln -s /usr/bin/python2 /usr/bin/python
SHELL ["/bin/bash", "-c"]

# Create the user 'mt'
RUN groupadd -r mt && useradd -m -g mt mt

ENV BUILD_SCRIPTS_DIR=/opt/build_scripts \
    APP_SOURCE_FOLDER=/opt/meteor/src \
    APP_BUNDLE_FOLDER=/opt/meteor/dist \
    METEOR_ALLOW_SUPERUSER=true

# Add entrypoint and build scripts
COPY ./scripts $BUILD_SCRIPTS_DIR

# Install Meteor
RUN $BUILD_SCRIPTS_DIR/install_meteor.sh
ENV PATH="/home/mt/.meteor:${PATH}"