# nginx-download

NGINX file server with fancy index and other rules to deliver mirrored openSUSE repositories.

## Build

```bash
podman build -t mirror-nginx-download . --no-cache
```

## Push

```bash
podman push mirror-nginx-download opensusebr/mirror-nginx-download:latest
podman push mirror-nginx-download opensusebr/mirror-nginx-download:$(date +"%Y%m%d")
```

## Pull

```bash
podman pull opensusebr/mirror-nginx-download
```

## Run

```bash
podman run -it --rm --read-only -v ./opensuse:/srv/pub/opensuse -p 80:8000 opensusebr/mirror-nginx-download
```

## Available modules

- stream
- fancyindex
- geoip2
- headers_more_filter

## File Configuration

### /etc/nginx/nginx.conf

Default configuration has everything that you need to run a mirror service.

It includes path rules, rate limits, tunning parameters and more.

Check the [nginx documentation](https://www.nginx.com/resources/wiki/start/topics/examples/full/) for more information.

## Volumes

### /srv/pub/opensuse

The path used as a file index.

This volume mount should be the same as in the rsync-transfer service.

### /srv/www/fancyindex

The fancy index HTML files that looks like the [download.opensuse.org](http://download.opensuse.org/).

It emulates the behavior of [download.opensuse.org](http://download.opensuse.org/), including colors, formats and icons.

It's possible to edit all the files if you mount this path as a volume.

There's an example to include your organization logo and URL as sponsors in the footer.

## Logs

### /var/log/nginx-access.log

Access log is written in JSON, can easily be parsed by machines.

### /var/log/nginx-error.log

Error log is the standard nginx log.
