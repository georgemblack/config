#!/bin/bash
apt-get update
apt-get install software-properties-common -y
add-apt-repository universe
add-apt-repository ppa:certbot/certbot -y
apt-get update
apt-get install python-certbot-nginx -y

# Manually
certbot --nginx certonly
certbot renew --dry-run