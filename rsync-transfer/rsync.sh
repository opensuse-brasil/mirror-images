LOG_FILE=/var/log/rsync.log
INCLUDE_FILE=/etc/rsync-include.txt
DEST=/srv/pub/opensuse
URL=${RSYNC_USER}@${RSYNC_HOST}::${RSYNC_MODULE}/opensuse/
EXTRA_ARGS=

echo "Starting rsync file transfer..."
echo "URL is '$URL'"

if [ ! -z "$RSYNC_DRYRUN" ]; then
    echo "Running in dry-run mode"
    EXTRA_ARGS=--dry-run
fi

rsync --recursive \
      --links \
      --times \
      --perms \
      --delay-updates \
      --delete-delay \
      --delete-excluded \
      --timeout=1800 \
      --include-from=$INCLUDE_FILE \
      --log-file=$LOG_FILE \
      --owner \
      --group \
      --chown=${RSYNC_CHOWN} \
      --human-readable \
      --itemize-changes \
      --stats \
      $EXTRA_ARGS \
      $URL $DEST
