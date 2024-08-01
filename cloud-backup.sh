#!/bin/bash

# directory to back up
DIR=""

# name of folder in remote to back up to
REMOTE_FOLDER="cloud-backup"

# timestamp for folder name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# compress directory for backup
tar -czf "$DIR-$TIMESTAMP.tar.gz" "$DIR"

# rclone remotes to back up to
REMOTE1=":"
REMOTE2=":"
REMOTE3=":"

# this script is designed to use the 3-2-1 backup rule, which means:
# 3 copies of the data
# 2 different media types
# 1 off site backup 

# backup 1
rclone sync "$DIR" "$REMOTE1/$REMOTE_FOLDER"

# backup 2
rclone sync "$DIR" "$REMOTE2/$REMOTE_FOLDER"

# backup 3, off site
rclone sync --crypt "$DIR" "$REMOTE3/$REMOTE_FOLDER"