# docker-portmap-server-rootless

![icon](icon-149.png)

[![GitHub main workflow](https://img.shields.io/github/actions/workflow/status/dmotte/docker-portmap-server-rootless/main.yml?branch=main&logo=github&label=main&style=flat-square)](https://github.com/dmotte/docker-portmap-server-rootless/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/dmotte/portmap-server-rootless?logo=docker&style=flat-square)](https://hub.docker.com/r/dmotte/portmap-server-rootless)

This is a :whale: **Docker image** containing an **OpenSSH server** that can be used for **remote port forwarding** only. This image is almost equivalent to [dmotte/docker-portmap-server](https://github.com/dmotte/docker-portmap-server) but it runs as a **non-root user**.

Inspired by: https://www.golinuxcloud.com/run-sshd-as-non-root-user-without-sudo/

> :package: This image is also on **Docker Hub** as [`dmotte/portmap-server-rootless`](https://hub.docker.com/r/dmotte/portmap-server-rootless) and runs on **several architectures** (e.g. amd64, arm64, ...). To see the full list of supported platforms, please refer to the [`.github/workflows/main.yml`](.github/workflows/main.yml) file. If you need an architecture which is currently unsupported, feel free to open an issue.

## Usage

> **Note**: this Docker image uses an **unprivileged user** to perform the remote port forwarding stuff. As a result, it will only be possible to use **port numbers > 1024**. However this is not a problem at all, since you can still leverage the **Docker port exposure feature** to bind to any port you want on your host (e.g. `-p "80:8080"`).

TODO you need **host keys** for the OpenSSH server and to generate an **SSH key pair** for the client, TODO exactly as the other image. The differences are: you have just only one root (not many dirs per each user) and the volumes must be writable by the `portmap` user inside the container. TODO how to:

```bash
docker volume create myvol
docker run --rm -v myvol:/v docker.io/library/busybox chown 100:101 /v
```

TODO In the container command you need to specify [which ports can be bound](https://man.openbsd.org/sshd_config#PermitListen)

TODO to start the server, see the other rootful image. The commands are very similar.

For a more complex example, refer to the [`docker-compose.yml`](docker-compose.yml) file.

## Development

If you want to contribute to this project, you can use the following one-liner to **rebuild the image** and bring up the **Docker-Compose stack** every time you make a change to the code:

```bash
docker-compose down && docker-compose up --build
```
