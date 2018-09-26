FROM golang:1.11 AS build

ARG GOOS
ARG GOARCH
RUN apt-get update && apt-get install -y git make curl build-essential git autoconf automake libtool unzip file bzr

FROM build as buildkit
RUN git clone https://github.com/moby/buildkit /go/src/github.com/moby/buildkit
WORKDIR /go/src/github.com/moby/buildkit
RUN mkdir .tmp; \
    PKG=github.com/moby/buildkit VERSION=$(git describe --match 'v[0-9]*' --dirty='.m' --always) REVISION=$(git rev-parse HEAD)$(if ! git diff --no-ext-diff --quiet --exit-code; then echo .m; fi); \
    echo "-X ${PKG}/version.Version=${VERSION} -X ${PKG}/version.Revision=${REVISION} -X ${PKG}/version.Package=${PKG}" | tee .tmp/ldflags

FROM buildkit as buildctl
ENV CGO_ENABLED=0
RUN go build -ldflags "$(cat .tmp/ldflags) -d" -o /usr/bin/buildctl ./cmd/buildctl

FROM buildkit as buildkitd
ENV CGO_ENABLED=1
RUN go build -installsuffix netgo -ldflags "$(cat .tmp/ldflags) -w -extldflags -static" -tags 'seccomp netgo cgo static_build' -o /usr/bin/buildkitd ./cmd/buildkitd


FROM scratch
COPY --from=buildctl /usr/bin/buildctl /
COPY --from=buildkitd /usr/bin/buildkitd /
COPY buildkit.service /
COPY install /
