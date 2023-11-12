FROM debian:12-slim
RUN apt-get update
RUN apt-get install -y wget
RUN wget -q https://raw.githubusercontent.com/filebrowser/get/master/get.sh 
RUN bash get.sh
RUN mkdir /storage
RUN mkdir /config
RUN mkdir /script
VOLUME ["/storage", "/config"]
ADD filebrowser.json /script/
ADD init.sh /script/
EXPOSE 8080/tcp
ENTRYPOINT ["/bin/bash", "/script/init.sh"]
