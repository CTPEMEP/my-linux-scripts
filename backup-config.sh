#! /bin/bash
# backup-config.sh - create backup important config files.
# author: CTPEMEP

BACKUP_DIR="$HOME/config-backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="config-backup-$DATE.tar.gz"

# Important config files to backup
CONFIG_FILES=(
    "$HOME/.bashrc"
    "$HOME/.bash_profile"
    "$HOME/.ssh/config"
    "/etc/ssh/sshd_config"
    "/etc/hosts"
    "/etc/resolv.conf"
)

echo "create backup config files"
echo ""


# Create folder to backups, if is not exist.
mkdir -p "$BACKUP_DIR"

#Collect exist files
FILES_TO_BACKUP=()
for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$file" ]; then
	FILES_TO_BACKUP+=("$file")
	echo "Added: $file"
    else
	echo "Missing: $file (not found)"
    fi
done

echo ""

if [ ${#FILES_TO_BACKUP[@]} -eq 0 ]; then
    echo "Is not files to backup."
    exit 1
fi

# Create archiv
echo "Creating archive: $BACKUP_NAME"
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "${FILES_TO_BACKUP[@]}"

# Check success
if [ $? -eq 0 ]; then
    echo "Backup successfull created!"
    echo "Locate: $BACKUP_DIR/$BACKUP_NAME"
    echo "Size: $(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)"
else
    echo "Error when creating backup!"
    exit 1
fi

echo "List last backup:"
ls -lh "$BACKUP_DIR/*.tar.gz 2>/dev/null | tail -5"
EOF
