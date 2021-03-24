FROM linuxserver/nextcloud:version-21.0.0

LABEL io.hass.version="21.0.0.1" io.hass.type="addon" io.hass.arch="armhf|aarch64|amd64"

ENV NEXTCLOUD_PATH="/data/config/www/nextcloud"

# modify/copy files
RUN sed -i "s|data|share/nextcloud|g" /etc/cont-init.d/*

RUN sed -i "s|config|data/config|g" /etc/cont-init.d/*

RUN sed -i "s|data|share/nextcloud|g" /etc/services.d/nginx/*

RUN sed -i "s|config|data/config|g" /etc/services.d/nginx/*

COPY root/ /

RUN ["chmod", "+x", "/defaults/nextcloud-perms.sh"]

VOLUME ["/share", "/ssl", "/data", "/media"]
