ARG BASE_IMAGE_TAG=jammy

FROM ghcr.io/linuxserver/baseimage-rdesktop-web:$BASE_IMAGE_TAG
# renovate: suite=jammy depName=nextcloud-desktop
ARG NEXTCLOUD_DESKTOP_VERSION=4.0.5-20260120.145034.0bcb41dd46-1.0~jammy1

LABEL maintainer="dangmai"

ENV \
  CUSTOM_PORT="8080" \
  GUIAUTOSTART="true" \
  HOME="/config"

RUN \
  echo "**** install packages ****" && \
  add-apt-repository ppa:nextcloud-devs/client && \
  apt-get update && \
  apt-get install -y --no-install-recommends seahorse less vim htop gnome-keyring tint2 nextcloud-desktop=$NEXTCLOUD_DESKTOP_VERSION && \
  dbus-uuidgen > /etc/machine-id && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY root/ /
