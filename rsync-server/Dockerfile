FROM registry.suse.com/bci/bci-micro:16.0 AS target
FROM registry.suse.com/bci/bci-base:16.0 AS builder

COPY --from=target / /target

RUN zypper -n --installroot /target --gpg-auto-import-keys install --no-recommends rsync system-user-nobody

RUN mkdir -p /target/srv/pub/opensuse

COPY rsyncd.conf /target/etc/rsyncd.conf

FROM scratch

COPY --from=builder /target /

VOLUME ["/srv/pub/opensuse", "/var/log"]

EXPOSE 873

STOPSIGNAL SIGTERM

RUN ln -sf /dev/stdout /var/log/rsyncd.log

CMD ["rsync", "--daemon", "--no-detach"]
