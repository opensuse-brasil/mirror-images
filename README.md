# mirror-images

Container images to create an openSUSE Mirror.

## rsync-transfer

A service that will transfer (mirror) the desired content from openSUSE servers into yours.

### Image

```bash
podman pull opensusebr/mirror-rsync-transfer
```

## rsync-server

A service that will serve the contents of for your mirror for openSUSE mirror scanner.

Similar to [rsync.opensuse.org](http://rsync.opensuse.org/).

### Image

```bash
podman pull opensusebr/mirror-rsync-server
```

## nginx-download

A download service that will serve the contents of for your mirror for Zypper and web browsing.

Similar to [download.opensuse.org](http://download.opensuse.org/).

### Image

```bash
podman pull opensusebr/mirror-nginx-download
```
