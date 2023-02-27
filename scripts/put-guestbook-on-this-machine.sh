#!/bin/sh

nginx_dir=${1:-/etc/nginx}

sudo pacman -Syu nginx

# Clone
mkdir ~/src
cd ~/src
git clone https://github.com/Simponic/guestbook 

cd guestbook 
npm ci

# Make .env
[ ! -f .env ] && cp .env.example .env && vim .env

# Make systemd service
if [ ! -f ~/.config/systemd/user/guestbookd.service ]
then
  mkdir -p ~/.config/systemd/user/
  cp guestbookd.service ~/.config/systemd/user
  vim ~/.config/systemd/user/guestbookd.service
fi

# /var/run socket
sudo mkdir /var/run/guestbookd
user=$USER
sudo chown -R $user:$user /var/run/guestbookd

# NGINX
nginx_config="
worker_processes 1;

events {
  worker_connections 1024;
}

http {
  include mime.types;
  default_type application/octet-stream;

  sendfile on;
  keepalive_timeout 65;

  include $nginx_dir/sites-enabled/*.http;
}
"

guestbook_config="
upstream soc {
  server unix:/var/run/guestbookd/guestbookd.sock;
}

server {
  listen 80;

  location / {
    proxy_pass http://soc;
    proxy_set_header X-Real-IP \\\$remote_addr;
    proxy_set_header X-Forwarded-For \\\$proxy_add_x_forwarded_for;
    proxy_set_header Host \\\$host;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \\\$http_upgrade;
    proxy_set_header Connection "upgrade";
  }
}
"

sudo mkdir $nginx_dir/sites-available $nginx_dir/sites-enabled
sudo sh -c "echo \"$nginx_config\" | sudo tee $nginx_dir/nginx.conf"
sudo sh -c "echo \"$guestbook_config\" | sudo tee $nginx_dir/sites-available/guestbook.conf.http"
sudo ln -s $nginx_dir/sites-available/guestbook.conf.http $nginx_dir/sites-enabled/guestbook.conf.http 

sudo systemctl daemon-reload
sudo systemctl enable --now nginx

systemctl daemon-reload --user
systemctl enable --user --now guestbookd

sudo ufw allow 80
