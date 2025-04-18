#!/bin/bash

# Load configuration
if [ -r "/etc/cs421_config.conf" ]; then
    source "/etc/cs421_config.conf"
else
    echo "Error: Config file not found or readable" >&2
    exit 1
fi

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starting server update..." >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE

# Update packages
sudo apt update >> $UPDATE_LOG_FILE 2>&1
sudo apt upgrade -y >> $UPDATE_LOG_FILE 2>&1
echo "[$(date "+%Y-%m-%d %H:%M:%S")] System packages updated" >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE

# Update API from GitHub
cd $API_DIR
git pull origin master >> $UPDATE_LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERROR: Git pull failed" >> $UPDATE_LOG_FILE
    exit 1
fi
echo "[$(date "+%Y-%m-%d %H:%M:%S")] API code updated from GitHub" >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE

# Restart web server
sudo systemctl restart apache2 >> $UPDATE_LOG_FILE 2>&1
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Apacche restarted" >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Update process completed" >> $UPDATE_LOG_FILE
echo "############################################" >> $UPDATE_LOG_FILE
echo " " >> $UPDATE_LOG_FILE
