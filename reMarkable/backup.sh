#!/bin/zsh

# Enable error handling options
set -e    # Exit immediately if a command exits with a non-zero status
set -u    # Treat unset variables as an error
set -o pipefail  # The return value of a pipeline is the status of the last command to exit with a non-zero status

# Function to handle scp
function safe_scp {
    scp "$@"
    if [[ $? -ne 0 ]]; then
        echo "Error: scp command failed"
        exit 1
    fi
}

INSTANCE=$(date +"%Y-%m-%d-%H%M%S")
REMARKABLE_BACKUP_DIR=$HOME/remarkable-backup/$INSTANCE

[ ! -d $REMARKABLE_BACKUP_DIR ] && echo "Creating backup directory - $REMARKABLE_BACKUP_DIR" && mkdir -p $REMARKABLE_BACKUP_DIR

echo "Creating remarkable backup at $REMARKABLE_BACKUP_DIR/"

safe_scp -r root@$IP_ADDRESS:/home/root/.local/share/remarkable/xochitl $REMARKABLE_BACKUP_DIR/.

echo ""
echo "==========================================================================================="
echo "Your reMarkable has been successfull backed up to $REMARKABLE_BACKUP_DIR"
echo "==========================================================================================="