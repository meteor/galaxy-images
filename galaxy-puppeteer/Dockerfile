FROM meteor/ubuntu:20210319

# Make sure we have xz-utils so we can untar node binary, and jq to parse
# star.json to choose the npm version.
RUN apt-get update && \
    apt-get install -y jq xz-utils && \
    rm -rf /var/lib/apt/lists/*

ADD ./app /app
RUN mkdir -p /app/bundle

# Include some popular versions of Node (last updated 2020-Apr-23; see
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
#2.1
RUN NODE_VERSION="12.22.0" /app/install_node.sh
#2.0
RUN NODE_VERSION="12.20.1" /app/install_node.sh
#1.10.2
RUN NODE_VERSION="12.16.1" /app/install_node.sh
#1.8.1
RUN NODE_VERSION="8.15.1" /app/install_node.sh

RUN NODE_VERSION="14.21.4" /app/install_node.sh

RUN apt-get update \
    && apt-get install -y wget gnupg \
    && apt-get update \
    && apt-get install -y fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -y clean
RUN apt-get -y update
RUN apt-get -y install dpkg

RUN  apt-get update \
     && apt-get install -y wget gnupg ca-certificates \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     # We install Chrome to get all the OS level dependencies, but Chrome itself
     # is not actually used as it's packaged in the node puppeteer library.
     # Alternatively, we could could include the entire dep list ourselves
     # (https://github.com/puppeteer/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix)
     # but that seems too easy to get out of date.
     && apt-get install -y google-chrome-stable \
     && rm -rf /var/lib/apt/lists/* 


CMD ["/app/run.sh"]

