#!/usr/bin/env bash
set -euo pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 <images.txt>"
  exit 1
fi

# build ci image names
arch=$(dpkg --print-architecture 2>/dev/null)
git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
export_filename="${1%.*}.${arch}.txt"
prefix="${git_branch}_"
postfix="_ci-${arch}"

# pull images and echo image names to file
failed_images=()
rm -f "${export_filename}"
while IFS= read -r image || [ -n "$image" ]; do
  repo="${image%:*}"
  tag="${image##*:}"
  image="${repo}:${prefix}${tag}${postfix}"
  if docker pull "${image}"; then
    echo "${image}" >> "${export_filename}"
  else
    echo "===================== Failed to pull image: ${image}" >&2
    failed_images+=("${image}")
  fi
done < "$1"

# remove trailing newline
if [ -f "${export_filename}" ]; then
  sed -z -i 's/\n\+$//' "${export_filename}"
fi

# echo failed images
if [ "${#failed_images[@]}" -ne 0 ]; then
  echo ""
  for img in "${failed_images[@]}"; do
    echo "[fail] ${img}"
  done
fi
