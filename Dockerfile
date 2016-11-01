FROM lsiobase/alpine
MAINTAINER sparklyballs

# environment settings
ENV CONFIG_DIR="/config"

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages, update ca-certificates and create needed symlink for libs
RUN \
 apk add --no-cache \
	ca-certificates \
	libc6-compat \
	wget && \
 update-ca-certificates && \
 mkdir -p \
	/lib64 && \
 ln /lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2 && \

# install cardigan
 wget -O \
 /tmp/cardigann-src.tgz \
	https://bin.equinox.io/c/3u8U4iwUn6o/cardigann-stable-linux-amd64.tgz && \
 tar xf \
 /tmp/cardigann-src.tgz -C \
	/tmp/ && \
 install -Dm755 \
	/tmp/cardigann \
	/usr/bin/cardigann && \

# cleanup
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 5060
VOLUME /config
