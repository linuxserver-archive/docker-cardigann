FROM lsiobase/alpine:3.7 as buildstage
############## build stage ##############
# currently cardigann doesn't build correctly using go 1.10
# hence using alpine 3.7 for build stage

# build variables
ARG GOPATH=/tmp/golang
ARG CARDIGANN_DIR=$GOPATH/src/github.com/cardigann/cardigann

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	g++ \
	gcc \
	git \
	go \
	make \
	nodejs-npm

RUN \
 echo "**** fetch source code and nvm ****" && \
 git clone https://github.com/cardigann/cardigann.git ${CARDIGANN_DIR} && \
 git clone https://github.com/creationix/nvm.git /root/.nvm && \
 git -C $CARDIGANN_DIR checkout $(git -C $CARDIGANN_DIR describe --tags --candidates=1 --abbrev=0)

RUN \
 echo "**** install node packages ****" && \
 cd ${CARDIGANN_DIR}/web && \
 npm install

RUN \
 echo "**** compile cardigann ****" && \
 cd ${CARDIGANN_DIR} && \
 export PATH=$GOPATH/bin:$PATH && \
 make setup && \
 make test && \
 make build && \
 make install
############## runtime stage ##############
FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment variables
ENV CONFIG_DIR=/config

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	ca-certificates

# copy files from build stage and local files
COPY --from=buildstage /tmp/golang/bin/cardigann /usr/bin/cardigann
COPY root/ /

# ports and volumes
EXPOSE 5060
VOLUME /config
