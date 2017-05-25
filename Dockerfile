FROM lsiobase/alpine:3.6
MAINTAINER sparklyballs

# build variables
ARG GOPATH=/tmp/golang
ARG CARDIGANN_DIR=$GOPATH/src/github.com/cardigann/cardigann

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment variables
ENV CONFIG_DIR=/config

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	git \
	go \
	make && \

# install runtime packages
 apk add --no-cache \
	ca-certificates && \

# compile cardigann
 git clone https://github.com/cardigann/cardigann.git "${CARDIGANN_DIR}" && \
 git -C $CARDIGANN_DIR checkout $(git -C $CARDIGANN_DIR describe --tags --candidates=1 --abbrev=0) && \
 make --debug --directory=$CARDIGANN_DIR install && \
	install -Dm755 $GOPATH/bin/cardigann /usr/bin/cardigann && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 5060
VOLUME /config
