FROM registry.opensuse.org/opensuse/leap:latest

RUN zypper in -y rsync

ENV RSYNC_HOST="rsync.opensuse.org"
ENV RSYNC_MODULE="opensuse-full-with-factory"
ENV RSYNC_PATH="/opensuse/"
ENV RSYNC_USER="opensuse"
ENV RSYNC_PASSWORD=""
ENV RSYNC_CHOWN="1000:1000"
ENV RSYNC_DRYRUN=""
ENV RSYNC_INCLUDE_FILE="/etc/rsync-include.txt"
ENV RSYNC_LOG_FILE="/var/log/rsync.log"
ENV RSYNC_DESTINATION="/srv/pub/opensuse"

RUN mkdir -p $RSYNC_DESTINATION

VOLUME ["/srv/pub/opensuse", "/var/log"]

STOPSIGNAL SIGTERM

RUN ln -sf /dev/stdout $RSYNC_LOG_FILE

ADD rsync.sh /bin/rsync-transfer
RUN chmod +x /bin/rsync-transfer

CMD rsync-transfer
