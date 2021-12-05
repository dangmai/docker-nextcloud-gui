ARG BASE_IMAGE_TAG=focal

FROM ghcr.io/linuxserver/baseimage-rdesktop-web:$BASE_IMAGE_TAG
ARG NEXTCLOUD_DESKTOP_VERSION

LABEL maintainer="dangmai"

ENV \
  CUSTOM_PORT="8080" \
  GUIAUTOSTART="true" \
  HOME="/config"

RUN \
  echo "**** install packages ****" && \
  add-apt-repository ppa:nextcloud-devs/client && \
  apt-get update && \
  apt-get install -y --no-install-recommends less vim htop gnome-keyring tint2 nextcloud-desktop=$NEXTCLOUD_DESKTOP_VERSION && \
  dbus-uuidgen > /etc/machine-id && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /
