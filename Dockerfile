FROM debian:12-slim
RUN apt-get update
RUN apt-get install -y curl php nginx php-fpm zip rtorrent
RUN mkdir /downloads
RUN mkdir /config
RUN mkdir /script
RUN mkdir /install
RUN touch /install/firstrun
VOLUME ["/downloads", "/config"]
ADD ruTorrent-4.2.8.zip /install/
ADD rtorrent.rc /install/
ADD default /install/
ADD init.sh /script/
EXPOSE 80/tcp
ENTRYPOINT ["/bin/bash", "/script/init.sh"]
