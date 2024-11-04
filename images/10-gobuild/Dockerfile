FROM golang:1.23-alpine3.20 AS gobuild
RUN apk -U add git gcc linux-headers musl-dev make libseccomp libseccomp-dev bash
COPY gobuild /usr/bin/
RUN rm -f /bin/sh && ln -s /bin/bash /bin/sh
WORKDIR /output
