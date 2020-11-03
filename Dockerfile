FROM nginx:1.19.3-alpine

RUN apk add --update npm supervisor

RUN mkdir -p /var/log/supervisor && mkdir -p /etc/supervisor/conf.d

RUN node -v

RUN npm -v

WORKDIR /app

VOLUME "/var/log/supervisor"

COPY supervisor.conf /etc/supervisor/supervisor.conf
COPY supervisor.nginx.conf /etc/supervisor/conf.d/nginx.conf

CMD supervisord -c /etc/supervisor/supervisor.conf