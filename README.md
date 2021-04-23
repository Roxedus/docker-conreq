# [Roxedus/docker-conreq](https://github.com/Roxedus/docker-conreq)

Container for [Conreq](https://github.com/Archmonger/Conreq)

```yml
---
version: "2.1"
services:
  conreq:
    image: ghcr.io/roxedus/conreq:latest
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
