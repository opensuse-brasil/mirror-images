# rsync-server

rsync server that allows openSUSE mirror scanner to query your mirrored data.

This server will provide an rsync module called `opensuse` containing all files in `/opensuse`.

The scanning happens from `195.135.220.0/22`.

> Recomendation: Restrict access to the IP above in your network security groups, server firewall or iptables.

## Build

```bash
podman build -t mirror-rsync-server . --no-cache
```

## Push

```bash
podman push mirror-rsync-server opensusebr/mirror-rsync-server:latest
podman push mirror-rsync-server opensusebr/mirror-rsync-server:$(date +"%Y%m%d")
```

## Pull

```bash
podman pull opensusebr/mirror-rsync-server
```

## Run

```bash
podman run -it --rm --read-only -v ./opensuse:/srv/pub/opensuse -p 873:873 opensusebr/mirror-rsync-server
```

## File Configuration

### /etc/rsyncd.conf

The default configuration has all the parameters required for mirror scanner to work.

Check the [Linux man page](https://linux.die.net/man/5/rsyncd.conf) for more information.

## Volumes

### /opensuse

The path used for opensuse module in rsync.

This volume mount should be the same as in the rsync-transfer service.

## Logs

### /var/log/rsyncd.log

The rsync access and error log.
