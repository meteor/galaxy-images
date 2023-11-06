FROM meteor/ubuntu:20210720

RUN useradd -ms /bin/bash mt
ENV NODE_VERSION="14.21.4" 
ENV NODE_URL="https://static.meteor.com/dev-bundle-node-os/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz"
ENV DIR_NODE="/usr/local"

# Make sure we have xz-utils so we can untar node binary, and jq to parse
# star.json to choose the npm version.
RUN apt-get update && \
    apt-get install --no-install-recommends -y jq xz-utils && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/mt


RUN curl -sSL "$NODE_URL" | tar -xz -C /usr/local/ && mv $DIR_NODE/node-v${NODE_VERSION}-linux-x64 $DIR_NODE/v$NODE_VERSION

# add node and npm to path so the commands are available
ENV NODE_PATH $DIR_NODE/v$NODE_VERSION/lib/node_modules
ENV PATH $DIR_NODE/v$NODE_VERSION/bin:$PATH

RUN chown -R mt:mt /usr/local/ /home/mt
USER mt

RUN npm install -g meteor@latest
