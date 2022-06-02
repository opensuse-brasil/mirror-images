FROM registry.opensuse.org/opensuse/leap:latest

RUN zypper in -y rsync

COPY rsyncd.conf /etc/rsyncd.conf

RUN groupadd nobody
RUN useradd -m -g nobody -c "nobody user" -s /bin/bash nobody

RUN mkdir -p /srv/pub/opensuse

VOLUME ["/srv/pub/opensuse", "/var/log"]

EXPOSE 873

STOPSIGNAL SIGTERM

RUN ln -sf /dev/stdout /var/log/rsyncd.log

CMD ["rsync", "--daemon", "--no-detach"]
