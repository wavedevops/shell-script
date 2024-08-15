source common.sh

dnf install mysql-server -y &>>LOGFILE
VALIDATE $? "install mysql"

systemctl enable mysqld
VALIDATE $? "enable mysql server"

systemctl start mysqld
VALIDATE $? "start mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1
#VALIDATE $? "setup mysql server root password"

mysql -h 172.31.94.9 -uroot -pExpenseApp@1 -e 'show databases;'
if [ $? -eq 0 ]; then
  echo "mysql already exists"
else
  mysql_secure_installation --set-root-pass ExpenseApp@1
fi
