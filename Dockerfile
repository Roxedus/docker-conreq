FROM lspipepr/alpine:3.16

# set version label
ARG CONREQ_VERSION

# Temp Defaults
ENV DATA_DIR=/config DEBUG=False

# hadolint ignore=DL3018,DL4006
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    bsd-compat-headers \
    build-base \
    cargo \
    curl \
    g++ \
    gcc \
    git \
    jq \
    libev-dev \
    libffi-dev \
    mariadb-dev \
    openssl-dev \
    py3-wheel \
    python3-dev && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    freetype-dev \
    fribidi-dev \
    harfbuzz-dev \
    jpeg-dev \
    lcms2-dev \
    mariadb-connector-c-dev \
    openjpeg-dev \
    py3-pip \
    python3 \
    tcl-dev \
    tiff-dev \
    tk-dev \
    zlib-dev && \
  echo "**** install app ****" && \
  mkdir -p /app/conreq && \
  echo "$CONREQ_VERSION" && \
  if [ -z "${CONREQ_VERSION}" ]; then \
    CONREQ_VERSION=$(curl -sX GET https://api.github.com/repos/archmonger/conreq/commits/develop \
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
  pip3 install --no-cache-dir -U --find-links https://wheel-index.linuxserver.io/alpine-3.16/ -r /app/conreq/requirements/main.txt && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /root/.cache \
    /root/.cargo \
    /tmp/*

EXPOSE 8000

# add local files
COPY root/ /
