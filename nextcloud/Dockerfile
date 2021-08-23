ARG BUILD_FROM=linuxserver/nextcloud:version-22.1.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}


ENV NEXTCLOUD_PATH="/data/config/www/nextcloud"

# modify/copy files
RUN sed -i "s|data|share/nextcloud|g" /etc/cont-init.d/*

RUN sed -i "s|config|data/config|g" /etc/cont-init.d/*

RUN sed -i "s|data|share/nextcloud|g" /etc/services.d/nginx/*

RUN sed -i "s|config|data/config|g" /etc/services.d/nginx/*

COPY root/ /

RUN ["chmod", "+x", "/defaults/nextcloud-perms.sh"]

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
