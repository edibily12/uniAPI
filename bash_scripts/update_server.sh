#!/bin/bash

LOG_FILE="/var/log/update.log"
API_DIR="/home/ubuntu/apps/uniAPI"

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starting server update..." >> $LOG_FILE
echo " " >> $LOG_FILE

# Update packages
sudo apt update >> $LOG_FILE 2>&1
sudo apt upgrade -y >> $LOG_FILE 2>&1
echo "[$(date "+%Y-%m-%d %H:%M:%S")] System packages updated" >> $LOG_FILE
echo " " >> $LOG_FILE

# Update API from GitHub
cd $API_DIR
git pull origin master >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERROR: Git pull failed" >> $LOG_FILE
    exit 1
fi
echo "[$(date "+%Y-%m-%d %H:%M:%S")] API code updated from GitHub" >> $LOG_FILE
echo " " >> $LOG_FILE

# Restart web server
sudo systemctl restart apache2 >> $LOG_FILE 2>&1
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Apacche restarted" >> $LOG_FILE
echo " " >> $LOG_FILE
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Update process completed" >> $LOG_FILE
echo "############################################" >> $LOG_FILE
echo " " >> $LOG_FILE
