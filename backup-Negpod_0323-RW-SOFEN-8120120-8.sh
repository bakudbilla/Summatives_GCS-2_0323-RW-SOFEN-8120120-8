#!/bin/bash

# Set the remote server details
host="a0dfc11ba139.a982e858.alu-cod.online"
username="a0dfc11ba139"
password="899c79fc532cd0591af1"

# Set the backup location
remote_directory="/home/sftp-student/03033/summative"

# Create a backup directory with timestamp
backup_directory="backup_$(date +%Y%m%d_%H%M%S)"

# Create the backup directory on the remote server
sshpass -p "$password" ssh "$username@$host" "mkdir $remote_directory/$backup_directory"

# Copy the local directory to the remote backup directory
sshpass -p "$password" scp -r negpod_0323-RW-SOFEN-8120120-8-q1 "$username@$host:$remote_directory/$backup_directory"
echo "Backup completed successfully. Backup directory: $backup_directory"
