FROM lsiobase/alpine
MAINTAINER sparklyballs

# environment settings
ENV CONFIG_DIR="/config"

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	tar && \

# install runtime packages and create needed symlink for libs
 apk add --no-cache \
	libc6-compat && \
 mkdir -p \
	/lib64 && \
 ln /lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2 && \

# install cardigan
 curl -o \
 /tmp/cardigann-src.tgz -L \
	https://bin.equinox.io/c/3u8U4iwUn6o/cardigann-stable-linux-amd64.tgz && \
 tar xf \
 /tmp/cardigann-src.tgz -C \
	/tmp/ && \
 install -Dm755 \
	/tmp/cardigann \
	/usr/bin/cardigann && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 5060
VOLUME /config
