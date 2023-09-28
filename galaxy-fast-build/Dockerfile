FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV UBUNTU_VERSION 20.04

# Update packages and install necessary dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    jq \
    curl \
    ca-certificates \
    python-is-python2 \
    rsync \
    libssl-dev \
    wget \
    build-essential \
    git && \
    # Clean up to reduce image size
    rm -rf /var/lib/apt/lists/*

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

ENV BUILD_SCRIPTS_DIR=/opt/build_scripts \
    APP_SOURCE_FOLDER=/opt/meteor/src \
    APP_BUNDLE_FOLDER=/opt/meteor/dist \
    METEOR_ALLOW_SUPERUSER=true \
    MONGO_URL=mongodb://localhost:27017/meteor 

# Add entrypoint and build scripts
COPY ./scripts $BUILD_SCRIPTS_DIR
COPY ./app $APP_SOURCE_FOLDER

# Install Meteor
RUN $BUILD_SCRIPTS_DIR/install_meteor.sh
ENV PATH="/root/.meteor:${PATH}"

# install dependencies, build app, and install node
RUN $BUILD_SCRIPTS_DIR/build_app.sh && \
    $BUILD_SCRIPTS_DIR/install_node.sh

WORKDIR $APP_BUNDLE_FOLDER/bundle

# start the app
CMD ["/bin/bash", "-c", "${BUILD_SCRIPTS_DIR}/run.sh"]
