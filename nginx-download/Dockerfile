FROM registry.suse.com/bci/bci-micro:16.0 AS target
FROM registry.suse.com/bci/bci-base:16.0 AS builder

ARG FANCYINDEX_VER=v0.6.0
ARG GEOIP2_VER=3.4
ARG HEADERS_MORE_VER=v0.39

WORKDIR /build

# these modules are not in BCI
RUN curl -L https://github.com/aperezdc/ngx-fancyindex/archive/refs/tags/${FANCYINDEX_VER}.tar.gz \
        | tar -xz -C /build && mv /build/ngx-fancyindex-* /build/fancyindex

RUN curl -L https://github.com/leev/ngx_http_geoip2_module/archive/refs/tags/${GEOIP2_VER}.tar.gz \
        | tar -xz -C /build && mv /build/ngx_http_geoip2_module-* /build/geoip2

RUN curl -L https://github.com/openresty/headers-more-nginx-module/archive/refs/tags/${HEADERS_MORE_VER}.tar.gz \
        | tar -xz -C /build && mv /build/headers-more-nginx-module-* /build/headers-more

RUN zypper install -y make nginx-source nginx-macros libmaxminddb-devel

RUN cd /usr/src/nginx/ && \
    ./configure --with-compat --with-stream \
      --add-dynamic-module=/build/fancyindex \
      --add-dynamic-module=/build/geoip2 \
      --add-dynamic-module=/build/headers-more && \
    make modules

COPY --from=target / /target

RUN zypper -n --installroot /target --gpg-auto-import-keys install --no-recommends nginx

RUN cp /usr/src/nginx/objs/*.so /target/usr/lib64/nginx/modules/

COPY nginx.conf /target/etc/nginx/nginx.conf
COPY fancyindex /target/srv/www/fancyindex

RUN mkdir -p /target/srv/pub/opensuse

# HACK: Hardcoded symlinks from openSUSE servers
RUN mkdir -p /target/srv/ftp/pub/
RUN ln -s /target/srv/pub/opensuse /target/srv/ftp/pub/opensuse

FROM scratch

COPY --from=builder /target /

VOLUME ["/srv/pub/opensuse/", "/srv/www/fancyindex"]

EXPOSE 80 443

STOPSIGNAL SIGTERM

RUN ln -sf /dev/stdout /var/log/nginx-access.log
RUN ln -sf /dev/stderr /var/log/nginx-error.log

CMD nginx -g 'daemon off;' -e /var/log/nginx-error.log
