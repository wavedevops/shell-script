#!/bin/bash

source common.sh

dnf install nginx -y
VALIDATE $? "install nginx"

systemctl enable nginx
VALIDATE $? "enable nginx"

systemctl start nginx
VALIDATE $? "start nginx"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "remove old html file "

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
VALIDATE $? "download frontend zip"

cd /usr/share/nginx/html &>>$LOGFILE
unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "Extracting frontend code"

#check your repo and path
cp /home/ec2-user/expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copied expense conf"


systemctl restart nginx