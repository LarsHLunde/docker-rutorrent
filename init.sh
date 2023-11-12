#!/bin/bash

FILE=/install/firstrun
if test -f "$FILE"; then
    rm -f /install/firstrun
    echo "Docker RuTorrent has been installed"
    echo "Start the docker the normal way and it will start normally"
    exit 0
fi

read  -n 1 -p "Input Selection:" mainmenuinput
