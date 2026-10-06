#!/bin/bash
BACKUP_DIR="$HOME/wordpress-stack/backups"
mkdir -p $BACKUP_DIR
sudo docker exec mysql_db mysqldump --no-tablespaces -u wordpress_user -pwordpress_db_pass wordpress > $BACKUP_DIR/wp_backup_$(date +%Y%m%d_%H%M%S).sql
echo "Backup executed on $(date)" >> $BACKUP_DIR/backup.log
