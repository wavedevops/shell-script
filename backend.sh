#!/bin/bash

source common.sh

dnf module disable nodejs -y
VALIDATE $? "disable nodejs version 16" &>>LOGFILE

dnf module enable nodejs:20 -y
VALIDATE $? "enable nodejs version 20" &>>LOGFILE

dnf install nodejs -y
VALIDATE $? "install nodejs" &>>LOGFILE


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

cd /app  &>>$LOGFILE
rm-rf /app/* &>>$LOGFILE
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "UNZIP backend dependencies"

npm install &>>$LOGFILE
VALIDATE $? "npm install"

cp /home/ec2-user/shell-script/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "copy from backend.service file"

systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "daemon reload"


dnf install mysql -y &>>$LOGFILE
VALIDATE $? "install mysql client"

mysql -h 172.31.94.9 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "send schema from mysql client"


systemctl start backend &>>$LOGFILE
systemctl enable backend &>>$LOGFILE
VALIDATE $? "start and enable backend"
