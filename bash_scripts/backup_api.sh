#!/bin/bash

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="${{ secrets.BACKUP_LOG_FILE }}"
BACKUP_DIR="${{ secrets.BACKUP_DIR }}"
API_DIR="${{ secrets.API_DIR }}"

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starting backup..." >> $LOG_FILE
echo " " >> $LOG_FILE

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup API files
tar -czf $BACKUP_DIR/api_backup_$TIMESTAMP.tar.gz $API_DIR 2>> $LOG_FILE
if [ $? -eq 0 ]; then
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] API backup successful" >> $LOG_FILE
else
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERROR: API backup failed" >> $LOG_FILE
fi

echo " " >> $LOG_FILE

# Backup database (MySQL)
DB_BACKUP_FILE="$BACKUP_DIR/db_backup_$TIMESTAMP.sql"
DB_USER="${{ secrets.DB_USER }}"
DB_PASS="${{ secrets.DB_PASS }}"
DB_NAME="${{ secrets.DB_NAME }}"
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > $DB_BACKUP_FILE 2>> $LOG_FILE
if [ $? -eq 0 ]; then
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] Database backup successful" >> $LOG_FILE
else
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERROR: Database backup failed" >> $LOG_FILE
fi
echo " " >> $LOG_FILE

# Cleanup old backups (older than 7 days)
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -exec rm {} \; 2>> $LOG_FILE
find $BACKUP_DIR -name "*.sql" -mtime +7 -exec rm {} \; 2>> $LOG_FILE
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Cleaned up backups older than 7 days" >> $LOG_FILE

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Backup process completed" >> $LOG_FILE
echo "###########################################" >> $LOG_FILE
echo " " >> $LOG_FILE
