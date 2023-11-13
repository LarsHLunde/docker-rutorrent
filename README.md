# docker-rutorrent
A debian based docker for RuTorrent using nginx

## How to install
```
git clone https://github.com/LarsHLunde/docker-rutorrent.git
cd docker-rutorrent
docker build -t rutorrent .
docker run -t \
  -v /root/rutorrent-config:/config \
  -v /downloads:/downloads \
  -p 80:80 \
  --name rutorrent \
  --restart unless-stopped \
  rutorrent
docker start rutorrent
```

## Nginx passthrough
I assume you're not just running one application on the server.  
So to run it through Nginx, preferably with signed TLS, here's the config:  
```
        location /rutorrent/ {
                rewrite ^/rutorrent(.*) $1 break;
                proxy_pass http://127.0.0.1:8080;
                client_max_body_size 100M;
                auth_basic "Restricted Content";
                auth_basic_user_file /etc/nginx/.htpasswd;
        }
```
