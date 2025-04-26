#!/bin/bash

UPDATE_LOG_FILE="/var/log/update.log"
API_DIR="/home/ubuntu/spring-boot-student-subjects-api"

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starting server update..." >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE

# Update packages
sudo apt update >> $UPDATE_LOG_FILE 2>&1
sudo apt upgrade -y >> $UPDATE_LOG_FILE 2>&1
echo "[$(date "+%Y-%m-%d %H:%M:%S")] System packages updated" >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE

# Update API from GitHub
cd $API_DIR
git pull origin main >> $UPDATE_LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERROR: Git pull failed" >> $UPDATE_LOG_FILE
    exit 1
fi
echo "[$(date "+%Y-%m-%d %H:%M:%S")] API code updated from GitHub" >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE

# Restart web server
sudo systemctl restart nginx >> $UPDATE_LOG_FILE 2>&1
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Nginx restarted" >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Update process completed" >> $UPDATE_LOG_FILE
echo "############################################" >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE
