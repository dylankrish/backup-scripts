#!/bin/bash

# directory to back up
DIR=""

# rclone remotes to back up to
REMOTE1=":"
REMOTE2=":"
REMOTE3=":"

# timestamp for folder names
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# this script is designed to use the 3-2-1 backup rule, which means:
# 3 copies of the data
# 2 different media types
# 1 off site backup 

# backup 1
rclone sync "$DIR" "$REMOTE1/$TIMESTAMP"

# backup 2
rclone sync "$DIR" "$REMOTE2/$TIMESTAMP"

# backup 3, off site
rclone sync --crypt "$DIR" "$REMOTE3/$TIMESTAMP"