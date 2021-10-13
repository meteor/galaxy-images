FROM meteor/ubuntu:20210720
SHELL ["/bin/bash", "-c"]

RUN useradd -ms /bin/bash mt
USER mt
WORKDIR /home/mt

ENV NVM_DIR /home/mt/.nvm
ENV NODE_VERSION 14.17.6
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:/home/mt/.meteor:$PATH

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.39.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g meteor@latest \
    && source $HOME/.bashrc

