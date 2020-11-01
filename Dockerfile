FROM lsiobase/alpine:3.12

# set version label
ARG CONREQ_VERSION

# Temp Defaults
ENV DJANGO_SUPERUSER_USERNAME=demo \
    DJANGO_SUPERUSER_EMAIL=email@gmail.home \
    DJANGO_SUPERUSER_PASSWORD=secretpass

# hadolint ignore=DL3018,DL4006
RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
    g++ \
    gcc \
    curl \
    jq \
    py3-wheel \
    python3-dev && \
 echo "**** install packages ****" && \
 apk add --no-cache \
    py3-pip \
    python3 && \
 echo "**** install app ****" && \
 mkdir -p /app/conreq && \
 echo $CONREQ_VERSION && \
 if [ -z ${CONREQ_VERSION+x} ]; then \
    CONREQ_VERSION=$(curl -sX GET https://api.github.com/repos/archmonger/conreq/commits/main \
	| jq -r '. | .sha'); \
 fi && \
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
