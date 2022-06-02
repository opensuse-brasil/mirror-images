FROM registry.opensuse.org/opensuse/leap:latest

RUN zypper in -y rsync

ENV RSYNC_HOST="rsync.opensuse.org"
ENV RSYNC_MODULE="opensuse-full-with-factory"
ENV RSYNC_USER="opensuse"
ENV RSYNC_PASSWORD=""
ENV RSYNC_CHOWN="1000:1000"
ENV RSYNC_DRYRUN=""

RUN mkdir -p /srv/pub/opensuse

VOLUME ["/srv/pub/opensuse", "/var/log"]

STOPSIGNAL SIGTERM

RUN ln -sf /dev/stdout /var/log/rsync.log

ADD rsync.sh /bin/rsync-transfer
RUN chmod +x /bin/rsync-transfer

CMD rsync-transfer
