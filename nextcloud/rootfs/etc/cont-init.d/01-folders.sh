#!/bin/bash
echo "Copying default configs"
cp /defaults/nginx/nginx.conf.sample /data/config/nginx/nginx.conf
cp /defaults/nginx/ssl.conf.sample /data/config/nginx/ssl.conf
cp /defaults/nginx/site-confs/default.conf.sample /data/config/nginx/site-confs/default.conf
