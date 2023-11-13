#!/bin/bash

FILE=/install/firstrun
if test -f "$FILE"; then
    rm -f /install/firstrun

    apt-get update
	apt-get install -y curl \
 		dialog \
		nginx \
		zip \
		rtorrent \
		php \
		php-fpm \
		php-cli  \
		php-dev  \
		php-xml  \
		php-curl  \
		php-xmlrpc  \
		php-json  \
		php-mbstring  \
		php-opcache  \
		php-zip \
		mediainfo \
    		sox \
      		geoip-database \
		unrar-free

    mkdir -p /config/session
    mkdir -p /config/watch
    
    mv /install/default /config/.

    unzip /install/ruTorrent*.zip -d /var/www/html > /dev/null
    mv /var/www/html/ruTorrent* /var/www/html/rutorrent

    mv /install/config.php /config/.
    mv /install/rtorrent.rc /config/.
    
    echo "Docker RuTorrent has been installed"
    echo "Start the docker the normal way and it will start normally"
    exit 0
fi

cp -f /config/config.php /var/www/html/rutorrent/conf/config.php
cp -f /config/default /etc/nginx/sites-enabled/.
cp -f /config/rtorrent.rc ~/.rtorrent.rc

php-fpm8.2
nginx

read  -n 1 -p "Input Selection:" mainmenuinput
