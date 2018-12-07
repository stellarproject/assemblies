FROM golang:1.11 AS build

ARG GOOS
ARG GOARCH
RUN apt-get update && apt-get install -y git make curl build-essential git autoconf automake libtool unzip file bzr
RUN git clone https://github.com/google/protobuf /tmp/protobuf && \
    cd /tmp/protobuf && \
    ./autogen.sh && \
    ./configure && make install
RUN go get -v github.com/LK4D4/vndr
RUN go get -v github.com/golang/protobuf/protoc-gen-go
RUN go get -v github.com/gogo/protobuf/protoc-gen-gofast
RUN go get -v github.com/gogo/protobuf/proto
RUN go get -v github.com/gogo/protobuf/gogoproto
RUN go get -v github.com/gogo/protobuf/protoc-gen-gogo
RUN go get -v github.com/gogo/protobuf/protoc-gen-gogofast
RUN go get -v github.com/stevvooe/protobuild
RUN go get -v github.com/golang/lint/golint
RUN go get -v github.com/tebeka/go2xunit

FROM build as runc
RUN apt-get update && apt-get install -y libseccomp-dev libapparmor-dev
RUN git clone https://github.com/opencontainers/runc /go/src/github.com/opencontainers/runc
WORKDIR /go/src/github.com/opencontainers/runc
RUN git reset --hard 20aff4f0488c6d4b8df4d85b4f63f1f704c11abd
RUN make BUILDTAGS="seccomp apparmor"

FROM build as containerd
RUN apt-get update && apt-get install -y libseccomp-dev btrfs-tools
RUN git clone https://github.com/containerd/containerd /go/src/github.com/containerd/containerd
WORKDIR /go/src/github.com/containerd/containerd
RUN make

FROM scratch
COPY containerd.service /
COPY install /install
COPY --from=runc /go/src/github.com/opencontainers/runc/runc /
COPY --from=containerd /go/src/github.com/containerd/containerd/bin/ctr /
COPY --from=containerd /go/src/github.com/containerd/containerd/bin/containerd /
COPY --from=containerd /go/src/github.com/containerd/containerd/bin/containerd-shim /
COPY --from=containerd /go/src/github.com/containerd/containerd/bin/containerd-shim-runc-v1 /
