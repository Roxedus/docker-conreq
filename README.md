# [Roxedus/docker-conreq](https://github.com/Roxedus/docker-conreq)

## This is built against the develop branch. You have been warned!

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
    volumes:
      - /path/to/config:/config
    ports:
      - 8000:8000
```
