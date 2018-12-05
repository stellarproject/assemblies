FROM golang:1.11 AS build

ARG GOOS
ARG GOARCH

ENV PROJECT github.com/stellarproject/vab
RUN git clone https://$PROJECT /go/src/$PROJECT
WORKDIR /go/src/$PROJECT
RUN make && cp -f vab /bin/

FROM scratch
COPY --from=build /bin/vab /
COPY install /
