# Tested with docker.io/library/alpine:3.19.1
FROM docker.io/library/alpine:latest

RUN apk add --no-cache openssh-server

EXPOSE 2222

COPY --chown=root:root --chmod=755 startup.sh /

RUN addgroup -S portmap && adduser -S portmap -G portmap && \
    install -oportmap -gportmap -dvm700 /ssh-host-keys /ssh-client-keys \
    /home/portmap/sshd /home/portmap/.ssh

USER portmap

COPY --chown=portmap:portmap --chmod=644 sshd_config /home/portmap/sshd/

ENTRYPOINT ["/bin/ash", "/startup.sh"]
