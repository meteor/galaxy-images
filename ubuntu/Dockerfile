FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV UBUNTU_VERSION 20.04

# Install some dependencies that Galaxy users have requested for their apps.  We
# document this list at http://galaxy-guide.meteor.com/base-image-packages.html
# Unfortunately, there's no safe way to upgrade any of these dependencies without
# potentially breaking existing users. We now encourage users to build their
# own custom base image rather than requesting us to install dependencies into
# the default base image.
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates python-is-python2 rsync \
      libssl-dev wget build-essential git && \
    rm -rf /var/lib/apt/lists/*
