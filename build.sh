#!/bin/sh

sudo podman run --rm --privileged multiarch/qemu-user-static --reset -p yes

# Remove unix:// from DOCKER_HOST
DOCKER_HOST=$(echo ${DOCKER_HOST} | sed 's/^unix:\/\///')

rm -rf ./build/

podman run --rm -it \
  -v "$(pwd):/work" \
  --privileged \
  --arch amd64 \
  -e BUILDPLATFORM=linux/amd64 \
  -e ARCH=amd64 \
  -v "${DOCKER_HOST}:/var/run/docker.sock" \
  ghcr.io/darkness4/k3os:latest-base

rm -rf ./build/

podman run --rm -it \
  -v "$(pwd):/work" \
  --privileged \
  --arch arm64 \
  --variant v8 \
  -e BUILDPLATFORM=linux/arm64/v8 \
  -e ARCH=arm64 \
  -e GOOS=linux \
  -e GOARCH=arm64 \
  -v "${DOCKER_HOST}:/var/run/docker.sock" \
  ghcr.io/darkness4/k3os:latest-base
