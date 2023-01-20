#! /bin/bash
umount /config
rm -rf /config
mkdir -p /data/config
ln -sf /data/config/ /
mkdir -p /ssl/nextcloud/keys
rm -r /data/config/keys
ln -sf /ssl/nextcloud/keys /data/config/
rm -r /data/config/nginx
chown -R abc:abc /data/config
alias php7=php
