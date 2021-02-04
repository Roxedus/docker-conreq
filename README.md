# [Roxedus/docker-conreq](https://github.com/Roxedus/docker-conreq)

## This is built againt the develop branch, you have been warned

```yml
---
version: "2.1"
services:
  conreq:
    image: ghcr.io/roxedus/conreq:develop
    container_name: conreq
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - SSL=false #optional
      - SSL_CERT=/config/crt.pem #Required when using SSL=true
      - SSL_KEY=/config/key.pem #Required when using SSL=true
    volumes:
      - /path/to/config:/config
    ports:
      - 8000:8000
```
