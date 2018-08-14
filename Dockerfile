FROM base/archlinux
LABEL maintainer="imriss@yahoo.com"

ENV SQUID_VERSION=4.2 \
    SQUID_CACHE_DIR=/var/cache/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN pacman -Syyu --noconfirm --needed \
 && pacman -S --noconfirm --needed squid \
 && rm -rf /var/cache/pacman/pkg/* \
 && groupadd proxy \
 && useradd -g proxy proxy

COPY squid.conf /etc/squid/
COPY mime_add.conf /root/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh \
 && cat /root/mime_add.conf >> /etc/squid/mime.conf

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
