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

# REMARKABLE_BACKUP_DIR=$HOME/remarkable-backup/$INSTANCE


echo "==========================================================================================="
echo " Restoring remarkable from $BACKUP_DIR/"
echo "==========================================================================================="

safe_scp -r $BACKUP_DIR/xochitl root@$IP_ADDRESS:/home/root/.local/share/remarkable/xochitl

echo ""
echo "==========================================================================================="
echo "Your reMarkable has been successfully restored from up to $BACKUP_DIR"
echo "==========================================================================================="
