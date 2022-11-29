ARG BUILD_FROM=lscr.io/linuxserver/nextcloud:25.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# modify/copy files

COPY run.sh /etc/cont-init.d/03-hassio

RUN ["chmod", "+x", "/etc/cont-init.d/03-hassio"]

RUN ["chmod", "+x", "/defaults/nextcloud-perms.sh"]

# Increase max file upload size
#RUN sed -i \
#	-e 's/upload_max_filesize=1024M/upload_max_filesize=10240M/g' \
#	-e 's/post_max_size=1024M/post_max_size=10240M/g' \
#    	/etc/php8/php.ini
RUN sed -i "s|client_max_body_size 512M;|client_max_body_size 10240M;|g" /defaults/nginx/site-confs/default.conf.sample

VOLUME ["/share", "/ssl", "/data", "/media"]

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Nextcloud" \
    io.hass.description="Nextcloud" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.type="addon" \
    maintainer="haberda" \
    org.label-schema.description="Nextcloud" \
    org.label-schema.build-date="${BUILD_DATE}" \
    org.label-schema.name="Nextcloud" \
    org.label-schema.schema-version="${BUILD_VERSION}" \
    org.label-schema.url="https://github.com/haberda/nextcloud-addon" \
    org.label-schema.usage="https://github.com/haberda/nextcloud-addon" \
    org.label-schema.vcs-ref="${BUILD_REF}" \
    org.label-schema.vcs-url="https://github.com/haberda/" \
    org.label-schema.vendor="No Vendor"
