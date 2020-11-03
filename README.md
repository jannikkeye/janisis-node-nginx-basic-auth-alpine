# janisis/node-nginx-basic-auth-alpine

Image containing nginx and node with process management done with supervisor.

## Example

Basic Node.js server:

```javascript
const http = require("http");

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Welcome! The example is working!");
});

server.listen(3000, "0.0.0.0", () => {
  console.log("Server running at http://0.0.0.0:3000");
});
```

Nginx configuration:

```conf
events {
    worker_connections  1024;
}

http {
    server {
        location / {
            auth_basic "Test";
            auth_basic_user_file .htpasswd;
            proxy_pass             http://0.0.0.0:3000;
        }
    }
}

```

Supervisor config:

```conf
[program:node]
command=node main.js
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
```

Dockerfile:

```Dockerfile
FROM janisis/node-nginx-basic-auth-alpine

COPY ./main.js .
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY processes.conf /etc/supervisor/conf.d/processes.conf
COPY ./.htpasswd /etc/nginx/.htpasswd
```

```sh
> docker build -t test:latest .

> docker run -p 8080:80 test:latest

2020-11-03 12:53:24,740 CRIT Supervisor is running as root.  Privileges were not dropped because no user is specified in the config file.  If you intend to run as root, you can set user=root in the config file to avoid this message.
2020-11-03 12:53:24,740 INFO Included extra file "/etc/supervisor/conf.d/nginx.conf" during parsing
2020-11-03 12:53:24,740 INFO Included extra file "/etc/supervisor/conf.d/processes.conf" during parsing
2020-11-03 12:53:24,744 INFO supervisord started with pid 1
2020-11-03 12:53:25,713 INFO spawned: 'nginx' with pid 7
2020-11-03 12:53:25,719 INFO spawned: 'node' with pid 8
2020-11-03 12:53:26,852 INFO success: nginx entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2020-11-03 12:53:26,852 INFO success: node entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```
