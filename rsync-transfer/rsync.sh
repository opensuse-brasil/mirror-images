RSYNC_HOST=${RSYNC_HOST:-rsync.opensuse.org}
RSYNC_MODULE=${RSYNC_MODULE:-opensuse-full-with-factory}
RSYNC_PATH=${RSYNC_PATH:-/}
RSYNC_USER=${RSYNC_USER:-opensuse}
RSYNC_PASSWORD=${RSYNC_PASSWORD}
RSYNC_CHOWN=${RSYNC_CHOWN}
RSYNC_INCLUDE_FILE=${RSYNC_INCLUDE_FILE}
RSYNC_LOG_FILE=${RSYNC_LOG_FILE}
RSYNC_DESTINATION=${RSYNC_DESTINATION:-/srv/pub/opensuse}

ME=$(basename $0)

function usage {
    echo "openSUSE Mirror - File Transfer"
    echo ""
    echo "Usage:"
    echo ""
    echo " ${ME} [-h <host>] [-m <module>] [-u <user>] [-d <path>] [-c <user:groups>] [--dry-run]"
    echo ""
    echo "Optional arguments:"
    echo ""
    echo " -s, --host          rsync host (default: ${RSYNC_HOST})"
    echo " -m, --module        rsync module (default: ${RSYNC_MODULE})"
    echo " -p, --path          rsync path in module (default: ${RSYNC_PATH})"
    echo " -u, --user          rsync user (default: ${RSYNC_USER})"
    echo " -d, --destination   destination of files transfered (default: ${RSYNC_DESTINATION})"
    echo " -c, --chown         change ownership of files in the transfer (default: ${RSYNC_CHOWN:-<not-set>})"
    echo " --dry-run           perform a trial run with no changes made"
    echo " -i, --include-file  only transfer files that match the pattern (default: ${RSYNC_INCLUDE_FILE:-<not-set>})"
    echo " -l, --log-file      write transfer log to file (default: ${RSYNC_LOG_FILE:-<not-set>})"
    echo " -h, --help          display this help and exit"
}

while test $# -gt 0; do
    case "$1" in
    -s|--host)
        RSYNC_HOST=$2
        shift 2
        ;;
    -m|--module)
        RSYNC_MODULE=$2
        shift 2
        ;;
    -p|--path)
        RSYNC_PATH=$2
        shift 2
        ;;
    -d|--destination)
        RSYNC_DESTINATION=$2
        shift 2
        ;;
    -u|--user)
        RSYNC_USER=$2
        shift 2
        ;;
    --dry-run)
        RSYNC_DRYRUN="1"
        shift 1
        ;;
    -c|--chown)
        RSYNC_CHOWN=$2
        shift 2
        ;;
    -i|--include-file)
        RSYNC_INCLUDE_FILE=$2
        shift 2
        ;;
    -l|--log-file)
        RSYNC_LOG_FILE=$2
        shift 2
        ;;
    -h|--help)
        usage
        exit 1
        ;;
    *)
        echo "Invalid option: $1"
        echo ""
        usage
        exit 1
    esac
done

URL=${RSYNC_USER}@${RSYNC_HOST}::${RSYNC_MODULE}${RSYNC_PATH}
EXTRA_ARGS=

echo "Starting rsync file transfer..."
echo "URL is '$URL'"

if [ ! -z "$RSYNC_DRYRUN" ]; then
    echo "Running in dry-run mode"
    EXTRA_ARGS="$EXTRA_ARGS --dry-run"
fi

if [ -z "$RSYNC_INCLUDE_FILE" ]; then
    echo "WARNING: No include file provided, syncing everything in module!"
else
    if [ -f "$RSYNC_INCLUDE_FILE" ]; then
        echo "Including rules from file: $RSYNC_INCLUDE_FILE"
        EXTRA_ARGS="$EXTRA_ARGS --include-from=$RSYNC_INCLUDE_FILE"
    else
        echo "Include file does not exists: $RSYNC_INCLUDE_FILE"
        exit 1
    fi
fi

if [ -z "$RSYNC_LOG_FILE" ]; then
    echo "No log file provided, logging to console"
else
    if [ -f "$RSYNC_LOG_FILE" ]; then
        echo "Logging to file: $RSYNC_LOG_FILE"
        EXTRA_ARGS="$EXTRA_ARGS --log-file=$RSYNC_LOG_FILE"
    fi
fi

if [ -d "$RSYNC_DESTINATION" ]; then
    RSYNC_DESTINATION=$(realpath $RSYNC_DESTINATION)
    echo "Transfer destination is '$RSYNC_DESTINATION'"
else
    echo "Destination does not exists: $RSYNC_DESTINATION"
    exit 1
fi

rsync --recursive \
      --links \
      --times \
      --perms \
      --delay-updates \
      --delete-delay \
      --delete-excluded \
      --timeout=1800 \
      --owner \
      --group \
      --chown=${RSYNC_CHOWN} \
      --human-readable \
      --itemize-changes \
      --stats \
      $EXTRA_ARGS \
      $URL $RSYNC_DESTINATION
