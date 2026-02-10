#!/bin/bash
#log-cleaner.sh - clean logs older specified days count
#use: ./log-cleaner.sh [days] [folder_with_logs]

DAYS=${1:-7} # default 7 days
LOG_DIR=${2:-/var/log} # default /var/log

echo "Cleaning logs older $DAYS days in folder $LOG_DIR"
echo ""

#Check exist folder
if [ ! -d "$LOG_DIR" ]; then
   echo "Error: folder $LOG_DIR is not exist!"
   exit 1
fi

#Check rights
if [ ! -r "$LOG_DIR" ]; then
   echo "Warning: is not rights to read $LOG_DIR"
   echo "Running scripts with sudo: sudo ./log-cleaner.sh $DAYS $LOG_DIR"
exit 1
fi

#Find and delete files

echo "Find log files..."
find "$LOG_DIR" -name "*.log" -type f -mtime +$DAYS 2>/dev/null | while read file; do
size=$(du -h "$file" | cut -f1)
echo "Deleting: $file (size: $size, changed: $(date -r "$file" +%Y-%m-%d))"
rm "$file"
done

echo ""
echo "Done! Found logs older $DAYS days and delete."
