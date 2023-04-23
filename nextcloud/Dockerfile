ARG BUILD_FROM=lscr.io/linuxserver/nextcloud:25.0.4
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# modify/copy files

#COPY run.sh /etc/cont-init.d/03-hassio

#RUN ["chmod", "+x", "/etc/cont-init.d/03-hassio"]

# Set S6 wait time
ENV S6_CMD_WAIT_FOR_SERVICES=1 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_SERVICES_GRACETIME=0

# Specific modifications
ARG CONFIGLOCATION="/share/nextcloud"
# hadolint ignore=SC2015,SC2086
RUN \
    # Change default data location
    for file in $(grep -Esril "/data" /etc /defaults); do sed -Ei "s=(/data)+(/| |$|\"|\')=$CONFIGLOCATION\2=g" $file; done && \
    \
    # modify data limits file
    sed -i \
    -e 's/upload_max_fileize=1024M/upload_max_fileize=10240M/g' \
    -e 's/post_max_size=1024M/post_max_size=10240M/g' \
    /etc/php*/php.ini || true && \
    \
    # Change location of executable
    sed -i "s|/config|/data/config|g" /usr/bin/occ && \
    sed -i "s|/config|/data/config|g" /usr/bin/updater.phar && \
    \
    # Change location of log
    sed -i "s|s6-setuidgid abc php -f /config/www/nextcloud/cron.php|(s6-setuidgid abc php -f /config/www/nextcloud/cron.php) \&>/proc/1/fd/1|g" /etc/crontabs/root && \
    \
    # Check bundled version and store it in /nextcloudversion
    mkdir -p /tmp2 && tar xf /app/nextcloud.tar.bz2 -C /tmp2 --strip-components=1 && \
    sed -n "s|.*\OC_VersionString = '*\(.*[^ ]\) *';.*|\1|p" /tmp2/version.php > /nextcloudversion && \
    rm -r /tmp2

# Global LSIO modifications
ARG CONFIGLOCATION="/data/config"
# hadolint ignore=SC2015, SC2013, SC2086
RUN \
    # Avoid custom-init.d duplications
    for file in $(grep -sril 'Potential tampering with custom' /etc/cont-init.d /etc/services.d /etc/s6-overlay/s6-rc.d); do rm -f $file; done \
    \
    # Create new config folder if needed
    && for file in $(grep -srl "PUID" /etc/cont-init.d /etc/s6-overlay/s6-rc.d); do sed -i "1a mkdir -p $CONFIGLOCATION" $file; done \
    \
    # Allow UID and GID setting
#     && for file in $(grep -srl "PUID" /etc/cont-init.d /etc/s6-overlay/s6-rc.d); do sed -i 's/bash/bashio/g' $file && sed -i '1a PUID="$(if bashio::config.has_value "PUID"; then bashio::config "PUID"; else echo "0"; fi)"' $file && sed -i '1a PGID="$(if bashio::config.has_value "PGID"; then bashio::config "PGID"; else echo "0"; fi)"' $file; done \
    \
    # Search occurences of /config and change it to the expected new config
    && for file in $(grep -Esril "/config" /etc /defaults); do sed -Ei "s=(/config)+(/| |$|\"|\')=$CONFIGLOCATION\2=g" $file; done \
    \
    # Avoid chmod /config
    && for file in /etc/services.d/*/* /etc/cont-init.d/* /etc/s6-overlay/s6-rc.d/*/*;do if [ -f $file ] && [[ ! -z $(awk '/chown.*abc:abc.*\\/,/.*\/config( |$)/{print FILENAME}' $file) ]] ; then sed -i "s|/config$|/data|g" $file; fi ;done \
    \
    # Docker mods addition
    #&& if [ -f /docker-mods ]; then sed -i 's|bash|bashio|g' /docker-mods && sed -i "1a if bashio::config.has_value \"DOCKER_MODS\"; then DOCKER_MODS=\$(bashio::config \"DOCKER_MODS\"); fi" /docker-mods; fi \
    \
    # Replace lsiown if not found
    && if [ ! -f /usr/bin/lsiown ]; then for file in $(grep -sril "lsiown" /etc); do sed -i "s|lsiown|chown|g" $file; done; fi

# Corrects permissions for s6 v3
RUN if [ -d /etc/cont-init.d ]; then chmod -R 755 /etc/cont-init.d; fi && \
    if [ -d /etc/services.d ]; then chmod -R 755 /etc/services.d; fi && \
    if [ -f /entrypoint.sh ]; then chmod 755 /entrypoint.sh; fi

#RUN sed -i "s|client_max_body_size 512M;|client_max_body_size 10240M;|g" /defaults/nginx/site-confs/default.conf.sample

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
