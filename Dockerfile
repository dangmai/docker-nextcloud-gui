FROM ghcr.io/linuxserver/baseimage-rdesktop-web:bionic

LABEL maintainer="dangmai"

ENV \
  CUSTOM_PORT="8080" \
  GUIAUTOSTART="true" \
  HOME="/config"

RUN \
  echo "**** install packages ****" && \
  add-apt-repository ppa:nextcloud-devs/client && \
  apt-get update && \
  apt-get install -y --no-install-recommends nextcloud-client && \
  dbus-uuidgen > /etc/machine-id && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /
