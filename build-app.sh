#!/bin/bash
set -eu

# build-app.sh takes a base image tag and app bundle URL / path, and
# builds a docker image for an application similar to how ImageBuilder
# builds it. The output image is tagged with "<repository>:<timestamp>".

# This script is for manual testing only. It's not used anywhere in
# production. This is useful since there's no testing framework set
# yet to verify changes to galaxy-app image.

cd "$(dirname "$0")"
source lib.sh

if [[ "$#" != 3 ]]; then
   echo "usage: $0 <base image> <bundle> <repository>" >&2
   exit 1
fi

baseimage="$1"
bundle="$2"
repository="$3"
workdir="$(mktemp -dt galaxy-app-build.XXXXXX)"
tag=$(TZ=UTC date +"%Y%m%dT%H%M%SZ")

cd "$workdir"

if [[ "${bundle}" =~ ^(http|https):// ]]; then
  echo "Fetching ${bundle}"
  curl -s "${bundle}" -O ./bundle.tgz
else
  cp "${bundle}" ./bundle.tgz
fi

# Dockerfile template
# Slightly different from embedded template in ImageBuilder,
# to support copying a bundle in local filesystem.
cat << EOF > Dockerfile
FROM ${baseimage}

COPY bundle.tgz /tmp/bundle.tgz
RUN bash -x /app/setup.sh file:///tmp/bundle.tgz
EOF

set -x
docker build -t "${repository}:${tag}" .
set +x

echo "Tag: ${repository}:${tag}"
echo "Run with "
echo "$ docker run --rm -p 3000:3000 -e ROOT_URL=<URL> ${repository}:${tag}"
