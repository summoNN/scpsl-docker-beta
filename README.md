# SCP: Secret Laboratory Server Docker Image

## Docker CLI

```
docker run -p 7777:7777/udp -v $(pwd)/config:/config ghcr.io/raftario/scpsl
```

## Docker Compose

```yml
services:
  scpsl:
    image: ghcr.io/raftario/scpsl
    restart: unless-stopped
  ports:
    - 7777:7777/udp
  volumes:
    - ./config:/config
```
