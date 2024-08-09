#!/bin/bash

# directory to back up
DIR=""

# name of backup
BACKUP_NAME="backup"

# timestamp for folder name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# compress directory for backup
tar -czf "$BACKUP_NAME-$TIMESTAMP.tar.gz" "$DIR"

# rclone remotes to back up to
REMOTE1=":"
REMOTE2=":"

# this script is designed to use the 3-2-1 backup rule, which means:
# 3 copies of the data (including original)
# 2 different media types
# 1 off site backup 

# backup 1
rclone copy "$BACKUP_NAME-$TIMESTAMP.tar.gz" "$REMOTE1/$BACKUP_NAME"

# backup 2, off site
rclone copy --crypt "$BACKUP_NAME-$TIMESTAMP.tar.gz" "$REMOTE2/$BACKUP_NAME"

# remove compressed archive once finished to save space
rm $BACKUP_NAME-$TIMESTAMP.tar.gz
