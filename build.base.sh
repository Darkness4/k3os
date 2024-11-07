#!/bin/sh

set -ex

sudo podman run --rm --privileged alekitto/qemu-user-static --reset -p yes

podman manifest rm ghcr.io/darkness4/k3os:latest-base || true

podman build \
  --manifest ghcr.io/darkness4/k3os:latest-base \
  --jobs=2 --platform=linux/amd64,linux/arm64/v8 \
  -f Dockerfile.base \
  .

podman manifest push --all ghcr.io/darkness4/k3os:latest-base docker://ghcr.io/darkness4/k3os:latest-base
