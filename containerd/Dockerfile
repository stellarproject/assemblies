FROM golang:1.11 as containerd
RUN git clone https://github.com/containerd/containerd /go/src/github.com/containerd/containerd
WORKDIR /go/src/github.com/containerd/containerd

FROM containerd AS proto3
RUN apt-get update && apt-get install -y autoconf automake g++ libtool unzip
RUN ./script/setup/install-protobuf

# Install runc
FROM containerd AS runc
RUN apt-get update && apt-get install -y curl libseccomp-dev
RUN ./script/setup/install-runc

FROM containerd AS build
RUN apt-get update && apt-get install -y btrfs-tools gcc git libseccomp-dev make xfsprogs

COPY --from=proto3 /usr/local/bin/protoc /usr/local/bin/protoc
COPY --from=proto3 /usr/local/include/google /usr/local/include/google

RUN make

FROM scratch
COPY containerd.service /containerd.service
COPY install /install
COPY --from=build /go/src/github.com/containerd/containerd/bin/* /
COPY --from=runc /usr/local/sbin/runc /runc
