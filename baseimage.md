# Base Image

This document outlines Galaxy's deployment pipeline and requirements for
container base images.

### Build Stage

Upon application deployment, the Galaxy backend attempts to pull a copy of the
base image tagged in `settings.json`, or the default image `meteor/galaxy-app`
if the setting is not set. Then the backend starts a temporary build container
using the base image, and calls the bash script at `/app/setup.sh` with an URL
to the deployed code bundle as the first positional argument. The script should
customize the container environment to the application's need, such as
installing system or NPM dependencies, as well as downloading the bundle. Once
it's completed, the backend saves this container as an image, which is used to
spawn new containers when Galaxy's scheduler rolls out the new version.

In any step of the build process, the build is aborted if the backend observes
an error. When a build fails, users should look for the output of commands
executed on the application's logs page in the Galaxy management interface to
determine the cause of failure. The backend will attempt up to 3 retries when it
encounters an error during the build stage, after which the deployment is
considered permanently failed. To force a rebuild, simply deploy again.

### Selecting Base Image in a Galaxy App

By default, Galaxy uses `meteor/galaxy-app:latest` as the base image for
applications. This image is specifically tailored for Meteor applications and is
designed to work with the `meteor deploy` command.

Users may change this behavior by writing to the `baseImage` key inside Galaxy's
section of `settings.json`. This is useful in rare cases of running non-Meteor
applications, as well as Meteor applications that require additional system
packages, such as database drivers.

To change the base image, `settings.json` should look like:

    {
      "galaxy.meteor.com": {
        "baseImage": {
          "repository": "username/repository",
          "tag": "latest"
        },
        ...
      }
      ...
    }

Both `repository` and `tag` fields are required if `baseImage` key is
present. The image must be hosted in a public repository on Docker Hub.

### Base Image Update

Docker tags are mutable: you can push a new image to an existing repository and
tag. Galaxy tries to always run applications on the current version of the
specified base image. This is achieved by periodically polling for any changes
in the base image from its registry. An update is detected when the
[content hash](https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/)
of the base image's manifest changes. Note that this hash (sometimes called
"digest") is not the same as the "Image ID" from the `docker images` command. It
changes only when the manifest, which specifies image layers, has changed. In
practice, if `docker build` introduces any change to files, a subsequent `docker
push` will trigger a base image update.

When an update is detected in a base image, the backend creates a new version
for each dependent application. New versions are automatically deployed if
builds succeed.

### Base Image Requirement

Galaxy expects a base image to meet the following requirements:

 - must be runnable without parameters, i.e. must provide either a default
   command through `CMD` or use the `ENTRYPOINT` instruction.
 - must provide an executable bash script at `/app/setup.sh`. This script is
   called during the build stage, with code bundle URL as first parameter.

`/app/setup.sh` is the ideal place to perform container environment
customization that requires application code to be present, e.g. `npm install`
for node apps. It's recommended to bundle system-level libraries in the base
image directly, e.g. by writing `apt-get` commands in `Dockerfile`.

##### Example: a base image for Python-based application

`Dockerfile`:

    FROM meteor/ubuntu:latest

    RUN apt-get update && \
        apt-get install build-essential python-dev python-pip curl ca-certificates && \
        rm -rf /var/lib/apt/lists/*

    COPY setup.sh /app/setup.sh
    CMD python /app/bundle/main.py

`setup.sh`:

    #!/bin/bash
    set -eu

    mkdir -p /code
    cd /code
    curl -s "$1" | tar xz

    pip install -r requirements.txt

Note: Building custom base images is an advanced feature. It's the user's
responsibility to maintain security updates in custom base images.

Two notes on the `apt-get` line above: First, we recommend that you delete
`/var/lib/apt/lists` after running `apt-get install`, so that the extra metadata
files don't take up space in your base image. Second, you should include the
`apt-get update &&` in the same RUN command as your `apt-get install`, so that
Docker doesn't create a layer with the result of just the `apt-get update` and
reuse it from a local cache when you run it again later; this can lead to
failures in `apt-get install` because the metadata files are no longer up to
date.
