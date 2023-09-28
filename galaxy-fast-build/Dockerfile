FROM alpine:3.14

# Install dependencies
RUN apk --no-cache add \
    jq \
    curl \
    ca-certificates \
    python2 \
    rsync \
    openssl-dev \
    wget \
    build-base \
    git

# Set python2 as the default python
RUN ln -s /usr/bin/python2 /usr/bin/python
SHELL ["/bin/bash", "-c"]

# Create the user 'mt'
RUN groupadd -r mt && useradd -m -g mt mt

ENV BUILD_SCRIPTS_DIR=/opt/build_scripts \
    APP_SOURCE_FOLDER=/opt/meteor/src \
    APP_BUNDLE_FOLDER=/opt/meteor/dist \
    METEOR_ALLOW_SUPERUSER=true \
    MONGO_URL=mongodb://localhost:27017/meteor 

# Add entrypoint and build scripts
COPY ./scripts $BUILD_SCRIPTS_DIR

# Copy app package.json and package-lock.json into container and app folder
COPY ./app/package*.json $APP_SOURCE_FOLDER/
COPY ./app $APP_SOURCE_FOLDER

# Install Meteor
RUN $BUILD_SCRIPTS_DIR/install_meteor.sh
ENV PATH="/home/mt/.meteor:${PATH}"


# install all dependencies, build app, install node, clean up
RUN $BUILD_SCRIPTS_DIR/build_app.sh && \
    $BUILD_SCRIPTS_DIR/install_node.sh


WORKDIR $APP_BUNDLE_FOLDER/bundle

# start the app
CMD ["/bin/bash", "-c", "${BUILD_SCRIPTS_DIR}/run.sh"]