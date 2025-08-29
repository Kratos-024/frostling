#!/bin/bash
LEVEL_NUM=${USER#level}
SERVICE_NAME="level${LEVEL_NUM}"
# Define names for the network and containers to keep them unique per session
SESSION_ID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)
USER_CONTAINER_NAME="${SERVICE_NAME}_${SESSION_ID}"

# Function to clean up the environment on exit
cleanup() {
    echo -e "\nShutting down the environment..."
    # Stop and remove both containers and the network
    sudo docker stop ${USER_CONTAINER_NAME} >/dev/null 2>&1
    sudo docker rm -f ${USER_CONTAINER_NAME}  >/dev/null 2>&1
}

# Trap the script's exit signal to run the cleanup function automatically
trap cleanup EXIT

echo "Running your environment..."
sudo docker run -it --rm --name ${USER_CONTAINER_NAME} child-level${LEVEL_NUM}-image /bin/bash

echo "Exiting from level${LEVEL_NUM}"
# exec sudo docker exec -it ${USER_CONTAINER_NAME} /bin/bash