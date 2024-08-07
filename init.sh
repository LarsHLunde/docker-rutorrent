#!/bin/bash

FILE=/install/firstrun
if test -f "$FILE"; then
    rm -f /install/firstrun

    mkdir -p /config/session
    mkdir -p /config/watch
    
    mv /install/default /config/.

    unzip /install/ruTorrent*.zip -d /var/www/html > /dev/null
    mv /var/www/html/ruTorrent* /var/www/html/rutorrent

    sed -i 's/memory_limit = 128M/memory_limit = 256M/' /etc/php/8.2/fpm/php.ini
    mv /install/config.php /config/.
    mv /install/rtorrent.rc /config/.
    mv /install/plugins.ini /config/.
    
    echo "Docker RuTorrent has been installed"
    echo "The RuTorrent instance should already be running"
    exit 0
fi

chmod 777 -R /config
chmod 777 -R /downloads
chown www-data:www-data -R /var/www/html/rutorrent

cp -f /config/config.php /var/www/html/rutorrent/conf/config.php
cp -f /config/plugins.ini /var/www/html/rutorrent/conf/plugins.ini
cp -f /config/default /etc/nginx/sites-enabled/.
cp -f /config/rtorrent.rc ~/.rtorrent.rc
rm -f /config/session/rtorrent.lock

export HOME=/root

php-fpm8.2
nginx
tmux new-session -d -s rtorrent 'rtorrent'

i=3

until [ $i -lt 3 ]
do
  sleep 10
  i=0
  i=$(($i+$(ps -ef | grep "php-fpm: master process" | grep -v grep | wc -l)))
  i=$(($i+$(ps -ef | grep "nginx: master process" | grep -v grep | wc -l)))
  i=$(($i+$(ps -ef | grep "tmux new-session -d -s rtorrent" | grep -v grep | wc -l)))
done

