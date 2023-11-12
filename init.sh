#!/bin/bash

FILE=/install/firstrun
if test -f "$FILE"; then
    rm -f /install/firstrun
    mv /install/default /config/.
    cp -f /config/default /etc/nginx/sites-enabled/.
    echo "Docker RuTorrent has been installed"
    echo "Start the docker the normal way and it will start normally"
    exit 0
fi

nginx
read  -n 1 -p "Input Selection:" mainmenuinput
