FROM meteor/ubuntu:20160830T182201Z_0f378f5

# Make sure we have xz-utils so we can untar node binary, and jq to parse
# star.json to choose the npm version.
RUN apt-get update && \
    apt-get install -y jq xz-utils && \
    rm -rf /var/lib/apt/lists/*

ADD ./app /app
RUN mkdir -p /app/bundle

# Include some popular versions of Node (last updated 2018-Jun-26; see
# docs/galaxy/base_image.md in the internal services repo for details on how to
# collect these stats). This reduces the size of the non-base image layers and
# speeds up app builds for apps using these versions. Other versions will still
# work.
#
# We avoid including any version older than 8.9.4, because some versions of npm
# older than 5.6.0 (included with 8.9.4) seem to hit
# https://github.com/npm/npm/issues/16807. The symptom is that running `npm -g
# install npm@xxx` from setup.sh would corrupt the npm installation, but only if
# Node is installed in a base image and npm is upgraded in the next image. So
# it's OK for setup.sh to install both Node and npm for older versions, but not
# for us to "cache" older Node versions.
RUN NODE_VERSION="8.9.4" /app/install_node.sh
RUN NODE_VERSION="8.11.1" /app/install_node.sh

CMD ["/app/run.sh"]
