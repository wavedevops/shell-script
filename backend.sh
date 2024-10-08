#!/bin/bash

source common.sh

dnf module disable nodejs -y &>>LOGFILE
VALIDATE $? "disable nodejs version 16"

dnf module enable nodejs:20 -y &>>LOGFILE
VALIDATE $? "enable nodejs version 20"

dnf install nodejs -y &>>LOGFILE
VALIDATE $? "install nodejs"


id expense &>>$LOGFILE
if [ $? -ne 0 ]
then
    useradd expense &>>$LOGFILE
    VALIDATE $? "Creating expense user"
else
    echo -e "Expense user already created...$Y SKIPPING $N"
fi

mkdir -p /app &>>$LOGFILE
VALIDATE $? "Creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading backend dependencies"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Extracted backend code"

npm install &>>$LOGFILE
VALIDATE $? "npm install"

#cp /home/ec2-user/shell-script/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
#VALIDATE $? "copy from backend.service file"

cp /home/centos/shell-script/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "copy from backend.service file"


systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "daemon reload"


dnf install mysql -y &>>$LOGFILE
VALIDATE $? "install mysql client"

mysql -h mysql.chowdary.cloud -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "send schema from mysql client"


systemctl start backend &>>$LOGFILE
systemctl enable backend &>>$LOGFILE
VALIDATE $? "start and enable backend"
