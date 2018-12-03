FROM alpine:latest as package
RUN apk add -U --no-cache wget
ENV VERSION=0.17.0
RUN wget https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz && \
	tar xvfz node_exporter-$VERSION.linux-amd64.tar.gz && \
	cd node_exporter-$VERSION.linux-amd64/ && \
	cp node_exporter /usr/bin/

FROM scratch
COPY --from=package /usr/bin/node_exporter /
COPY node-exporter.service /
COPY install /
