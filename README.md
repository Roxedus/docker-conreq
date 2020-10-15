# [Roxedus/docker-conreq](https://github.com/Roxedus/docker-conreq)

## **FOR DEMO PURPOSES ONLY**


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
      - DJANGO_SUPERUSER_USERNAME=demo #optional
      - DJANGO_SUPERUSER_EMAIL=email@gmail.home #optional
      - DJANGO_SUPERUSER_PASSWORD=secretpass #optional
    volumes:
      - /path/to/config:/config
    ports:
      - 8000:8000
```
