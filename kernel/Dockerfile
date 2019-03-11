FROM ubuntu:18.04 as builder

RUN apt-get update && apt-get install -y \
	build-essential \
	bc \
	devscripts \
	xz-utils \
	wget \
	curl \
	ca-certificates \
	bison \
	flex \
	cpio \
	libelf-dev \
	kmod \
	libssl-dev \
	git \
	make

ENV KERNEL_VERSION=5.0.1
ENV WIREGUARD_VERSION=0.0.20190227
ENV WIREGUARD_URL=https://git.zx2c4.com/WireGuard/snapshot/WireGuard-${WIREGUARD_VERSION}.tar.xz

ADD https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-${KERNEL_VERSION}.tar.xz linux.tar.xz

RUN mkdir /linux && \
	tar --strip-components=1 -xpf linux.tar.xz -C /linux

ADD config /linux/.config

# WireGuard
RUN curl -SsL "${WIREGUARD_URL}" -o /wireguard.tar.xz

RUN mkdir /wireguard && \
	tar --strip-components=1 -xpf wireguard.tar.xz -C /wireguard

WORKDIR /linux

ENV PKGVERSION 1terra

RUN /wireguard/contrib/kernel-tree/create-patch.sh | patch -p1
RUN make olddefconfig
RUN make -j "$(getconf _NPROCESSORS_ONLN)" KDEB_PKGVERSION=$PKGVERSION INSTALL_MOD_STRIP=1 bindeb-pkg

FROM scratch

ENV KERNEL_VERSION=5.0.1

COPY --from=builder /linux-headers-${KERNEL_VERSION}_1terra_amd64.deb /linux-headers.deb
COPY --from=builder /linux-image-${KERNEL_VERSION}_1terra_amd64.deb /linux-image.deb
COPY --from=builder /linux-image-${KERNEL_VERSION}-dbg_1terra_amd64.deb /linux-image.deb
COPY --from=builder /linux-libc-dev_1terra_amd64.deb /linux-image.deb
COPY install /install
