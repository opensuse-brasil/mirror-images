# rsync-transfer

rsync client that transfers the desired content from openSUSE servers into yours.

This service should run as a cron job in Swarm or Kubernetes, it is not a daemon.

## Build

```bash
podman build -t mirror-rsync-transfer . --no-cache
```

## Push

```bash
podman push mirror-rsync-transfer opensusebr/mirror-rsync-transfer:latest
podman push mirror-rsync-transfer opensusebr/mirror-rsync-transfer:$(date +"%Y%m%d")
```

## Pull

```bash
podman pull opensusebr/mirror-rsync-transfer
```

## Run

```bash
podman run -it --rm --read-only -v ./opensuse:/srv/pub/opensuse -v ./rsync-include.txt:/etc/rsync-include.txt opensusebr/mirror-rsync-transfer
```

## File Configuration

### /etc/rsync-include.txt

You need to define what you want to tranfer in `/etc/rsync-include.txt`.

If `/etc/rsync-include.txt` is empty or if it's all inclusive (`*`) it will download
everything available in the mirror module.

The `RSYNC_MODULE` env var and the `/etc/rsync-include.txt` file work together,
set them accordingly.

## Environment Variables

### RSYNC_HOST

The mirror server, should be `rsync.opensuse.org` or `stage.opensuse.org`.

Default: `rsync.opensuse.org`

### RSYNC_MODULE

The mirror module to use.
Check available modules [here](https://mirrors.opensuse.org/list/rsyncinfo-stage.o.o.txt).

The rsync module `opensuse-full-with-factory` is over 3 TB.

Default: `opensuse-full-with-factory`

### RSYNC_PATH

The path inside the module.
This affects the include file.

Default: `/opensuse/`

### RSYNC_USER

The mirror user to authenticate.

Default: `opensuse`

### RSYNC_PASSWORD

The mirror password to authenticate.

Default: **Not Set**

### RSYNC_CHOWN

The `user:group` that will own the files.

Default: `1000:1000`

### RSYNC_DRYRUN

Run rsync in dry-run mode. No files are changed.
This is good to test the include file rules.

Set any value to run in dry-run mode.

Default: **Not Set**

## Volumes

### /srv/pub/opensuse

The path where all transfered files (rpms, isos and metadata) will be placed.

You **MUST** mount this path to a path in the host machine.

## Logs

### /var/log/rsync.log

The rsync clone log.
