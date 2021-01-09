FROM ghcr.io/linuxserver/baseimage-alpine:3.12

# set version label
ARG CONREQ_VERSION

# Temp Defaults
ENV DATA_DIR=/config

# hadolint ignore=DL3018,DL4006
RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
    build-base \
    curl \
    freetype-dev \
    fribidi-dev \
    g++ \
    gcc \
    harfbuzz-dev \
    jpeg-dev \
    jq \
    lcms2-dev \
    libffi-dev \
    openjpeg-dev \
    openssl-dev \
    py3-wheel \
    python3 \
    python3-dev \
    python3-dev \
    tcl-dev \
    tiff-dev \
    tk-dev \
    zlib-dev && \
 echo "**** install packages ****" && \
 apk add --no-cache \
    py3-pip \
    python3 && \
 echo "**** install app ****" && \
 mkdir -p /app/conreq && \
 echo "$CONREQ_VERSION" && \
 if [ -z "${CONREQ_VERSION}" ]; then \
    CONREQ_VERSION=$(curl -sX GET https://api.github.com/repos/archmonger/conreq/commits/main \
	| jq -r '. | .sha'); \
 fi && \
 echo "$CONREQ_VERSION" && \
 curl -o \
 /tmp/conreq.tar.gz -L \
    "https://github.com/archmonger/conreq/archive/${CONREQ_VERSION}.tar.gz" && \
 tar xf \
 /tmp/conreq.tar.gz -C \
    /app/conreq --strip-components=1 && \
 echo "**** install pip packages ****" && \
 pip3 install --no-cache-dir -U -r /app/conreq/requirements.txt && \
 echo "**** cleanup ****" && \
 apk del --purge \
    build-dependencies && \
 rm -rf \
    /root/.cache \
    /tmp/*

# add local files
COPY root/ /
