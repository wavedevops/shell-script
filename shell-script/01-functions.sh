#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ];
then
  echo "your a not sudo privilege"
  exit 1
else
  echo "your a supper user"
fi