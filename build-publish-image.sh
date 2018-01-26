#!/bin/bash
set -eu

# build-publish-image.sh builds docker image using Dockerfile specification
# from folders, and pushes it out to Docker Hub.

source "$(dirname "$0")/lib.sh"

function usage() {
  echo "Usage: $0 <galaxy-app|ubuntu> [build args...]"
  echo "Run \"docker build --help\" to look up build command arguments."
  exit 1
}

if [[ $# -lt 1 ]]; then
  usage
fi

account="meteor"
repo="$1"
args="${*:2}"

if [ -z "${repo}" ]; then
  usage
fi

tag=$(compute_tag)
echo "repo=${repo} tag=${tag}"

cd "${repo}"
set -x
docker build -t "${account}/${repo}:${tag}" ${args} .
docker push "${account}/${repo}:${tag}"
