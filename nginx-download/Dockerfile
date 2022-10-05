FROM registry.opensuse.org/opensuse/leap:latest

RUN zypper addrepo https://download.opensuse.org/repositories/server:http/openSUSE_Leap_$(source /etc/os-release; echo $VERSION)/server:http.repo
RUN zypper -n --no-gpg-checks refresh
RUN zypper in -y nginx nginx-module-fancyindex nginx-module-geoip2 nginx-module-headers-more

COPY nginx.conf /etc/nginx/nginx.conf
COPY fancyindex /srv/www/fancyindex

RUN mkdir -p /srv/pub/opensuse

# HACK: Hardcoded symlinks from openSUSE servers
RUN mkdir -p /srv/ftp/pub/
RUN ln -s /srv/pub/opensuse /srv/ftp/pub/opensuse

VOLUME ["/srv/pub/opensuse/", "/srv/www/fancyindex"]

EXPOSE 80 443

STOPSIGNAL SIGTERM

RUN ln -sf /dev/stdout /var/log/nginx-access.log
RUN ln -sf /dev/stderr /var/log/nginx-error.log

CMD nginx -g 'daemon off;' -e /var/log/nginx-error.log
