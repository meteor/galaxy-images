FROM ubuntu:14.04.4

ENV DEBIAN_FRONTEND noninteractive
ENV UBUNTU_VERSION 14.04.4

RUN apt-get update && \
    apt-get --yes upgrade && \
    apt-get install -y curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install some dependencies that Galaxy users have requested for their apps.  We
# document this list at http://galaxy-guide.meteor.com/base-image-packages.html
# Unfortunately, there's no safe way to upgrade any of these dependencies without
# potentially breaking existing users. We now encourage users to build their
# own custom base image rather than requesting us to install dependencies into
# the default base image.

RUN apt-get update && \
    apt-get install -y rsync phantomjs libpoppler-qt4-dev libcairo2-dev \
      imagemagick libssl-dev wget xfonts-base xfonts-75dpi build-essential \
      graphicsmagick git libjpeg-dev poppler-utils && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb \
    && dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb \
    && rm wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
