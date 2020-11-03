FROM ghcr.io/jannikkeye/node-nginx-basic-auth-alpine:1.0.0

COPY ./main.js .
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY processes.conf /etc/supervisor/conf.d/processes.conf
COPY ./.htpasswd /etc/nginx/.htpasswd
