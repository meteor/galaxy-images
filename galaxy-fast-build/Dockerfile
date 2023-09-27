FROM meteor/ubuntu:20210720
SHELL ["/bin/bash", "-c"]

# Make sure we have jq to parse star.json to choose the npm version.
RUN apt-get update && \
    apt-get install --no-install-recommends -y jq && \
    rm -rf /var/lib/apt/lists/*

# Create the user 'mt'
RUN groupadd -r mt && useradd -m -g mt mt

ENV BUILD_SCRIPTS_DIR /opt/build_scripts
ENV APP_SOURCE_FOLDER /opt/meteor/src
ENV APP_BUNDLE_FOLDER /opt/meteor/dist
# Fix permissions warning; https://github.com/meteor/meteor/issues/7959
ENV METEOR_ALLOW_SUPERUSER true

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

# Set environment variables
ENV ROOT_URL http://localhost
ENV PORT 3000

# Expose port and set working directory
EXPOSE 3000
WORKDIR $APP_BUNDLE_FOLDER/bundle

# start the app
CMD ["/bin/bash", "-c", "${BUILD_SCRIPTS_DIR}/run.sh"]
