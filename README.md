# [Roxedus/docker-conreq](https://github.com/Roxedus/docker-conreq)

## **FOR DEMO PURPOSES ONLY**

Default username and password is `demo` and `secretpass` if not specified with `-e password`

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
      - password=secretpass #optional
    volumes:
      - /path/to/config:/config
    ports:
      - 8000:8000
```
