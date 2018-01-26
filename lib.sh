#!/bin/bash
set -e

function compute_tag() {
  local datetime
  datetime="$(TZ=UTC date +"%Y%m%dT%H%M%SZ")"
  local dirty_prefix=""
  if [[ -n "$(git status --porcelain)" ]]; then
    dirty_prefix="dirty_"
  fi
  local commit
  commit="$(git rev-parse --short HEAD)"

  # Usually we build releases from master; if not, we include the branch name in
  # the version to make it easier to find.
  local branch
  branch="$(git symbolic-ref --short HEAD)"
  local branch_suffix=""
  if [[ "${branch}" != "master" ]]; then
    # Clean up branch characters (esp slash)
    branch_suffix="_${branch//[^a-zA-Z0-9_.-]/-}"
  fi

  echo "${dirty_prefix}${datetime}_${commit}${branch_suffix}"
}
