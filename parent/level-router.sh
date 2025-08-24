#!/bin/bash
LEVEL_NUM=${USER#level}

if ! sudo docker ps --format "{{.Names}}" | grep -q "^level${LEVEL_NUM}-container$"; then
    echo "Starting level${LEVEL_NUM} container..."
    sudo docker run -d --name level${LEVEL_NUM}-container child-level${LEVEL_NUM} 2>/dev/null || {
        echo "Failed to start container. Trying to start existing container..."
        sudo docker start level${LEVEL_NUM}-container 2>/dev/null
    }
    sleep 2
fi

echo "Connecting to level${LEVEL_NUM} container..."
exec sudo docker exec -it level${LEVEL_NUM}-container /bin/bash