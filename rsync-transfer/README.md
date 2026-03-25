# rsync-transfer

A simple rsync client that transfers the desired content from openSUSE servers into yours.

This service should run as a cron job in Swarm or Kubernetes, it is not a daemon.

## Usage

To run the transfer, use the following command:

```bash
podman run -it --rm -v /host/path/to/opensuse:/srv/pub/opensuse:Z -v ./rsync-include-example.txt:/etc/rsync-include.txt:Z ghcr.io/opensuse-brasil/rsync-transfer:latest
```

**Note:** Update the volumes accordingly.

To test the transfer without downloading anything, use the following command:

```bash
podman run -it --rm -e RSYNC_DRYRUN=1 -v /host/path/to/opensuse:/srv/pub/opensuse:Z -v ./rsync-include-example.txt:/etc/rsync-include.txt:Z ghcr.io/opensuse-brasil/rsync-transfer:latest
```

DRY RUN gives you an estimate of disk size usage.

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
Check available modules [here](https://en.opensuse.org/openSUSE:Mirror_infrastructure#rsync_modules).

The default rsync module is over 5 TB.

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
