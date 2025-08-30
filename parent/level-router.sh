#!/bin/bash

LEVEL_NUM=${USER#level}
SERVICE_NAME="level${LEVEL_NUM}"
SESSION_ID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)

# Define unique names for all potential resources
USER_CONTAINER_NAME="${SERVICE_NAME}_user_${SESSION_ID}"
TARGET_CONTAINER_NAME="${SERVICE_NAME}_target_${SESSION_ID}"
NETWORK_NAME="${SERVICE_NAME}_net_${SESSION_ID}"

# Function to clean up the environment on exit
cleanup() {
    echo -e "\nShutting down the environment..."
    # Gracefully stop and remove containers and network if they exist
    if sudo docker ps -a --format '{{.Names}}' | grep -q "^${USER_CONTAINER_NAME}$"; then
        sudo docker rm -f ${USER_CONTAINER_NAME} >/dev/null 2>&1
    fi
    if sudo docker ps -a --format '{{.Names}}' | grep -q "^${TARGET_CONTAINER_NAME}$"; then
        sudo docker rm -f ${TARGET_CONTAINER_NAME} >/dev/null 2>&1
    fi
    if sudo docker network ls --format '{{.Name}}' | grep -q "^${NETWORK_NAME}$"; then
        sudo docker network rm ${NETWORK_NAME} >/dev/null 2>&1
    fi
}

# Trap the script's exit signal to run the cleanup function automatically
trap cleanup EXIT

echo "Running your environment for Level ${LEVEL_NUM}..."

# --- Special multi-container logic for Level 16 ---
if [ "$LEVEL_NUM" = "16" ]; then
    echo "Setting up multi-container environment..."

    # 1. Create the isolated network
    sudo docker network create --internal ${NETWORK_NAME}

    # 2. Run the target container in the background with a specific hostname
    echo "Starting target server..."
    sudo docker run -d --rm \
        --name ${TARGET_CONTAINER_NAME} \
        --network ${NETWORK_NAME} \
        --hostname frostling-server \
        child-level16-target-image

    # 3. Run the user's client container interactively, attached to the same network
    echo "Starting your container. Your target is the host named 'frostling-server'."
    sudo docker run -it --rm \
        --name ${USER_CONTAINER_NAME} \
        --network ${NETWORK_NAME} \
        child-level16-image /bin/bash

# --- Default logic for all other single-container levels ---
else
    sudo docker run -it --rm \
        --name ${USER_CONTAINER_NAME} \
        child-level${LEVEL_NUM}-image /bin/bash
fi

# The 'trap' will handle cleanup automatically upon exit.
echo "Exiting from level${LEVEL_NUM}"
