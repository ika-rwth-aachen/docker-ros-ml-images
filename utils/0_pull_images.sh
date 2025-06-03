#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 <images.txt>"
  exit 1
fi

arch=$(dpkg --print-architecture 2>/dev/null)
git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
export_filename="${1%.*}.${arch}.txt"
prefix="${git_branch}_"
postfix="_ci-${arch}"

rm -f "${export_filename}"
while IFS= read -r image; do
  repo="${image%:*}"
  tag="${image##*:}"
  image="${repo}:${prefix}${tag}${postfix}"
  if docker pull "${image}"; then
    echo "${image}" >> "${export_filename}"
  fi
done < "$1"
