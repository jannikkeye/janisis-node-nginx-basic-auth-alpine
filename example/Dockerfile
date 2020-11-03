FROM janisis/node-nginx-basic-auth-alpine

COPY ./main.js .
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY processes.conf /etc/supervisor/conf.d/processes.conf
COPY ./.htpasswd /etc/nginx/.htpasswd
