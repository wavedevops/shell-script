#!/bin/bash

source common.sh

dnf install nginx -y

systemctl enable nginx

systemctl start nginx

rm -rf /usr/share/nginx/html/*


curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip

cd /usr/share/nginx/html


unzip /tmp/frontend.zip


vim /etc/nginx/default.d/expense.conf


proxy_http_version 1.1;

location /api/ { proxy_pass http://localhost:8080/; }

location /health {
  stub_status on;
  access_log off;
}

systemctl restart nginx