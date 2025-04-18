#!/bin/bash

# Load configuration
source /etc/backup_config.conf

TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starting backup..." >> "$BACKUP_LOG_FILE"
echo " " >> "$BACKUP_LOG_FILE"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup API files
tar -czf "$BACKUP_DIR/api_backup_$TIMESTAMP.tar.gz" -C / "$(echo "$API_DIR" | sed 's|^/||')" 2>> "$BACKUP_LOG_FILE"
if [ $? -eq 0 ]; then
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] API backup successful" >> "$BACKUP_LOG_FILE"
else
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERROR: API backup failed" >> "$BACKUP_LOG_FILE"
fi

echo " " >> "$BACKUP_LOG_FILE"

# Backup database (MySQL)
DB_BACKUP_FILE="$BACKUP_DIR/db_backup_$TIMESTAMP.sql"
mysqldump --defaults-extra-file=<(printf "[mysqldump]\nuser=%s\npassword=%s" "$DB_USER" "$DB_PASS") "$DB_NAME" > "$DB_BACKUP_FILE" 2>> "$BACKUP_LOG_FILE"
if [ $? -eq 0 ]; then
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] Database backup successful" >> "$BACKUP_LOG_FILE"
else
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERROR: Database backup failed" >> "$BACKUP_LOG_FILE"
fi

echo " " >> "$BACKUP_LOG_FILE"

# Cleanup old backups (older than 7 days)
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -delete 2>> "$BACKUP_LOG_FILE"
find "$BACKUP_DIR" -name "*.sql" -mtime +7 -delete 2>> "$BACKUP_LOG_FILE"
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Cleaned up backups older than 7 days" >> "$BACKUP_LOG_FILE"

echo "[$(date "+%Y-%m-%d %H:%M:%S")] Backup process completed" >> "$BACKUP_LOG_FILE"
echo "###########################################" >> "$BACKUP_LOG_FILE"
echo " " >> "$BACKUP_LOG_FILE"
