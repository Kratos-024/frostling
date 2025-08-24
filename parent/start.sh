#!/bin/bash

echo "Starting SSH daemon..."
/usr/sbin/sshd &

# Wait for SSH to start
sleep 2

# Debug Docker socket permissions
echo "=== Docker Socket Debug ==="
if [ -S /var/run/docker.sock ]; then
    ls -la /var/run/docker.sock
    DOCKER_GID=$(stat -c %g /var/run/docker.sock)
    echo "Docker socket GID: $DOCKER_GID"
    
    # Create/modify docker group to match socket GID
    if ! getent group docker >/dev/null; then
        addgroup -g $DOCKER_GID docker
    else
        # Modify existing group
        groupmod -g $DOCKER_GID docker 2>/dev/null || echo "Could not change docker group GID"
    fi
    
    # Add level users to docker group
    for i in $(seq 0 20); do
        adduser level$i docker 2>/dev/null || echo "Could not add level$i to docker group"
    done
    
    echo "Updated group memberships"
else
    echo "Docker socket not found"
fi

# Test Docker access as root
echo "Testing Docker access as root..."
if docker info >/dev/null 2>&1; then
    echo "✓ Docker daemon accessible as root"
    
    # Start all level containers
    echo "Starting level containers..."
    for i in $(seq 0 20); do
        echo "Starting level${i} container..."
        if docker run -d --name level${i}-container child-level${i} 2>/dev/null; then
            echo "✓ level${i} container started"
        else
            echo "✗ level${i} container failed to start (may already exist)"
            # Try to start if it exists but stopped
            docker start level${i}-container 2>/dev/null && echo "  → level${i} container restarted"
        fi
    done
else
    echo "✗ Docker daemon not accessible"
fi

echo "=== Container Status ==="
docker ps --format "table {{.Names}}\t{{.Status}}" 2>/dev/null || echo "Cannot list containers"

echo "=== Setup Complete ==="
echo "SSH server running on port 22"
echo "Users: level0-level20 (password same as username)"

# Keep container running
while true; do 
    sleep 3600
done