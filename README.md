# docker-portmap-server-rootless

This is a :whale: **Docker image** containing an **OpenSSH server** that can be used for **remote port forwarding** only. This image is almost equivalent to [dmotte/docker-portmap-server](https://github.com/dmotte/docker-portmap-server) but it runs as a **non-root user**.

TODO

Inspired by https://www.golinuxcloud.com/run-sshd-as-non-root-user-without-sudo/

TODO add link to this rootless project inside the rootful one

```bash
docker volume create myvol
docker run --rm -v myvol:/v docker.io/library/busybox chown 100:101 /v
```
