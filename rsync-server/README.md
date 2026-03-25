# rsync-server

rsync server that allows openSUSE mirror scanner to query your mirrored data.

This server will provide an rsync module called `opensuse` containing all files in `/opensuse`.

The scanning happens from `195.135.220.0/22`.

> Recomendation: Restrict access to the IP above in your network security groups, server firewall or iptables.

## Usage

To run the server, use the following command:

```bash
podman run -it --rm -v /host/path/to/opensuse:/srv/pub/opensuse:Z -p 873:873 ghcr.io/opensuse-brasil/rsync-server:latest
```

**Note:** Update the volume accordingly.

## File Configuration

### /etc/rsyncd.conf

The default configuration has all the parameters required for mirror scanner to work.

Check the [Linux man page](https://linux.die.net/man/5/rsyncd.conf) for more information.

## Volumes

### /srv/pub/opensuse

The path used for opensuse module in rsync.

This volume mount should be the same as in the rsync-transfer service.

## Logs

### /var/log/rsyncd.log

The rsync access and error log.
