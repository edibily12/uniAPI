#!/bin/bash

LOG_FILE="/var/log/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Create log file if doesn't exist
sudo touch $LOG_FILE
sudo chown $(whoami):$(whoami) $LOG_FILE

echo "[$TIMESTAMP] Starting server health check..." >> $LOG_FILE
echo " " >> $LOG_FILE
# CPU Check (warning if > 80%)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "[$TIMESTAMP] CPU Usage: $CPU_USAGE%" >> $LOG_FILE
if (( $(echo "$CPU_USAGE > 80" | bc -l) )); then
    echo "[$TIMESTAMP] WARNING: High CPU usage!" >> $LOG_FILE
fi
echo " " >> $LOG_FILE

# Memory Check (warning if < 10% free)
MEM_FREE=$(free -m | awk 'NR==2{printf "%.2f", $4*100/$2}')
echo "[$TIMESTAMP] Memory Free: $MEM_FREE%" >> $LOG_FILE
if (( $(echo "$MEM_FREE < 10" | bc -l) )); then
    echo "[$TIMESTAMP] WARNING: Low free memory!" >> $LOG_FILE
fi
echo " " >> $LOG_FILE

# Disk Check (warning if < 10% free)
DISK_FREE=$(df -h / | awk 'NR==2{print $5}' | tr -d '%')
echo "[$TIMESTAMP] Disk Used: $DISK_FREE%" >> $LOG_FILE
if [ "$DISK_FREE" -gt 90 ]; then
    echo "[$TIMESTAMP] WARNING: Low disk space!" >> $LOG_FILE
fi
echo " " >> $LOG_FILE

# Web Server Check
if systemctl is-active --quiet apache2; then
    echo "[$TIMESTAMP] Apache is running" >> $LOG_FILE
else
    echo "[$TIMESTAMP] ERROR: Apache is not running!" >> $LOG_FILE
fi
echo " " >> $LOG_FILE

# API Endpoint Checks
check_endpoint() {
    if curl -s -o /dev/null -w "%{http_code}" "http://localhost:9090/api/$1" | grep -q 200; then
        echo "[$TIMESTAMP] $1 endpoint: OK" >> $LOG_FILE
    else
        echo "[$TIMESTAMP] ERROR: $1 endpoint not responding!" >> $LOG_FILE
    fi
}

check_endpoint "students"
check_endpoint "subjects"

echo "[$TIMESTAMP] Health check completed" >> $LOG_FILE
echo "##############################################################" >> $LOG_FILE
echo " " >> $LOG_FILE
