#!/bin/bash

FILE=/install/firstrun
if test -f "$FILE"; then
    rm -f /install/firstrun

    apt-get update
    apt-get install -y curl php nginx php-fpm zip rtorrent php-json

    mkdir -p /config/session
    mkdir -p /config/watch
    
    mv /install/default /config/.

    unzip /install/ruTorrent*.zip -d /var/www/html > /dev/null
    mv /var/www/html/ruTorrent* /var/www/html/rutorrent

    mv /install/rtorrent.rc /config/.
    
    echo "Docker RuTorrent has been installed"
    echo "Start the docker the normal way and it will start normally"
    exit 0
fi

cp -f /config/default /etc/nginx/sites-enabled/.
cp -f /config/rtorrent.rc ~/.rtorrent.rc

nginx
read  -n 1 -p "Input Selection:" mainmenuinput
