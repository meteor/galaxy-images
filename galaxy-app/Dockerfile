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
RUN NODE_VERSION="8.9.3" /app/install_node.sh && \
    NODE_VERSION="4.8.4" /app/install_node.sh && \
    NODE_VERSION="4.8.3" /app/install_node.sh && \
    NODE_VERSION="4.8.2" /app/install_node.sh && \
    NODE_VERSION="4.8.1" /app/install_node.sh && \
    NODE_VERSION="4.8.0" /app/install_node.sh && \
    NODE_VERSION="4.7.3" /app/install_node.sh

CMD ["/app/run.sh"]
