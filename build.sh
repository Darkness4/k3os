#!/bin/sh

set -ex

sudo podman run --rm --privileged multiarch/qemu-user-static --reset -p yes

# Remove unix:// from DOCKER_HOST
DOCKER_HOST=$(echo ${DOCKER_HOST} | sed 's/^unix:\/\///')

GIT_TAG=$(git describe --tags --abbrev=0)

rm -rf ./build/

podman run --rm -it \
  -v "$(pwd):/work" \
  --privileged \
  --arch amd64 \
  -e BUILDPLATFORM=linux/amd64 \
  -e ARCH=amd64 \
  -v "${DOCKER_HOST}:/var/run/docker.sock" \
  ghcr.io/darkness4/k3os:latest-base

podman tag ghcr.io/darkness4/k3os:latest "ghcr.io/darkness4/k3os:latest-amd64"
podman tag ghcr.io/darkness4/k3os:latest "ghcr.io/darkness4/k3os:${GIT_TAG}-amd64"
podman push "ghcr.io/darkness4/k3os:${GIT_TAG}-amd64"
podman push "ghcr.io/darkness4/k3os:latest-amd64"
# shellcheck disable=SC2046
podman rmi -f $(podman images --filter=reference="ghcr.io/darkness4/k3os*:dev" -q)

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

podman tag ghcr.io/darkness4/k3os:latest ghcr.io/darkness4/k3os:latest-arm64
podman tag ghcr.io/darkness4/k3os:latest "ghcr.io/darkness4/k3os:${GIT_TAG}-arm64"
podman push "ghcr.io/darkness4/k3os:${GIT_TAG}-arm64"
podman push "ghcr.io/darkness4/k3os:latest-arm64"

# Build the manifest
podman manifest create ghcr.io/darkness4/k3os:${GIT_TAG} \
  ghcr.io/darkness4/k3os:${GIT_TAG}-amd64 \
  ghcr.io/darkness4/k3os:${GIT_TAG}-arm64

podman manifest push --all ghcr.io/darkness4/k3os:${GIT_TAG} docker://ghcr.io/darkness4/k3os:${GIT_TAG}
