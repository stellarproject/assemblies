FROM golang:1.11 AS build

ARG GOOS
ARG GOARCH
RUN apt-get update && apt-get install -y git make curl build-essential git autoconf automake libtool unzip file bzr

FROM build as cni
RUN apt-get update && apt-get install -y build-essential
RUN git clone https://github.com/containernetworking/plugins /go/src/github.com/containernetworking/plugins
WORKDIR /go/src/github.com/containernetworking/plugins
RUN ./build.sh

FROM scratch
COPY --from=cni /go/src/github.com/containernetworking/plugins/bin/bridge /
COPY --from=cni /go/src/github.com/containernetworking/plugins/bin/macvlan /
COPY --from=cni /go/src/github.com/containernetworking/plugins/bin/dhcp /
COPY --from=cni /go/src/github.com/containernetworking/plugins/bin/loopback /
COPY install /
