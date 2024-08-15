source common.sh

TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

dnf install mysql-server -y &>>LOGFILE
VALIDATE $? "install mysql"

systemctl enable mysqld &>>LOGFILE
VALIDATE $? "enable mysql server"

systemctl start mysqld &>>LOGFILE
VALIDATE $? "start mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1
#VALIDATE $? "setup mysql server root password"

mysql -h 172.31.94.9 -uroot -pExpenseApp@1 -e 'show databases;' &>>LOGFILE
if [ $? -eq 0 ]; then
  echo -e "$Y mysql already exists $N"
else
  mysql_secure_installation --set-root-pass ExpenseApp@1 &>>LOGFILE
  VALIDATE $? "setup mysql root password"
fi
