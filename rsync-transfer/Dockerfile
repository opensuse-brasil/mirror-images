FROM registry.suse.com/bci/bci-micro:16.0 AS target
FROM registry.suse.com/bci/bci-base:16.0 AS builder

COPY --from=target / /target

RUN zypper -n --installroot /target --gpg-auto-import-keys install --no-recommends rsync

RUN mkdir -p /target/srv/pub/opensuse

ADD rsync.sh /target/bin/rsync-transfer
RUN chmod +x /target/bin/rsync-transfer

FROM scratch

COPY --from=builder /target /

ENV RSYNC_HOST="rsync.opensuse.org"
ENV RSYNC_MODULE="opensuse-full-with-factory"
ENV RSYNC_PATH="/opensuse/"
ENV RSYNC_USER="opensuse"
ENV RSYNC_PASSWORD=""
ENV RSYNC_CHOWN="1000:1000"
ENV RSYNC_DRYRUN=""
ENV RSYNC_INCLUDE_FILE="/etc/rsync-include.txt"

VOLUME ["/srv/pub/opensuse", "/var/log"]

STOPSIGNAL SIGTERM

RUN ln -sf /dev/stdout /var/log/rsync.log

CMD rsync-transfer
