[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# [linuxserver/cardigann](https://github.com/linuxserver/docker-cardigann)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/cardigann.svg)](https://microbadger.com/images/linuxserver/cardigann "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/cardigann.svg)](https://microbadger.com/images/linuxserver/cardigann "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/cardigann.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/cardigann.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-cardigann/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-cardigann/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/cardigann/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/cardigann/latest/index.html)

[Cardigann](https://github.com/cardigann/cardigann) a server for adding extra indexers to Sonarr, SickRage and CouchPotato via Torznab and TorrentPotato proxies. Behind the scenes Cardigann logs in and runs searches and then transforms the results into a compatible format.


[![cardigann](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/cardigann.png)](https://github.com/cardigann/cardigann)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/cardigann` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=cardigann \
  -e PUID=1001 \
  -e PGID=1001 \
  -e SOCKS_PROXY=IP:PORT \
  -e HTTP_PROXY=IP:PORT \
  -p 5060:5060 \
  -v <path to data>:/config \
  --restart unless-stopped \
  linuxserver/cardigann
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  cardigann:
    image: linuxserver/cardigann
    container_name: cardigann
    environment:
      - PUID=1001
      - PGID=1001
      - SOCKS_PROXY=IP:PORT
      - HTTP_PROXY=IP:PORT
    volumes:
      - <path to data>:/config
    ports:
      - 5060:5060
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 5060` | The port for the Cardigann webinterface |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e SOCKS_PROXY=IP:PORT` | for using a socks proxy (optional) |
| `-e HTTP_PROXY=IP:PORT` | for using a HTTP proxy (optional) |
| `-v /config` | Cardigann config |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


&nbsp;
## Application Setup

Access the webui at `<your-ip>:5060`, for more information check out [Cardigann](https://github.com/cardigann/cardigann).

By adding a variable to the run command, `SOCKS_PROXY` or `HTTP_PROXY` cardigann can be used with a proxy, *eg* `-e SOCKS_PROXY=localhost:1080`

The folder `/config/definitions` can be used to add additional tracker definitions (for more info see [Additional definitions](https://github.com/cardigann/cardigann#definitions) ).



## Support Info

* Shell access whilst the container is running: `docker exec -it cardigann /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f cardigann`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' cardigann`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/cardigann`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/cardigann`
* Stop the running container: `docker stop cardigann`
* Delete the container: `docker rm cardigann`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start cardigann`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/cardigann`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **01.02.19:** - Multi arch images and pipeline build logic
* **14.01.19:** - Add multi arch and pipeline logic
* **22.08.18:** - Rebase to alpine 3.8
* **06.05.18:** - Use buildstage in Dockerfile
* **06.12.17:** - Rebase to alpine 3.7
* **12.08.17:** - Add npm install to build stage
* **25.05.17:** - Rebase to alpine 3.6
* **07.02.17:** - Rebase to alpine 3.5
* **03.11.16:** - Compiled using [sstamoulis'](https://github.com/sstamoulis) method
* **01.11.16:** - Initial Release
