FROM debian:12-slim
RUN mkdir /downloads
RUN mkdir /config
RUN mkdir /script
RUN mkdir /install
RUN touch /install/firstrun
RUN apt-get update
RUN apt-get install -y dialog tmux nginx zip rtorrent php php-fpm php-cli php-dev php-xml php-curl php-xmlrpc php-json php-mbstring php-opcache php-zip mediainfo sox geoip-database unrar-free
VOLUME ["/downloads", "/config"]
ADD ruTorrent-*.zip /install/
ADD rtorrent.rc /install/
ADD default /install/
ADD config.php /install/
ADD plugins.ini /install/
ADD init.sh /script/
EXPOSE 80/tcp
EXPOSE 55555/tcp
ENTRYPOINT ["/bin/bash", "/script/init.sh"]
