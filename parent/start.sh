#!/bin/bash

echo "Starting SSH daemon..."
/usr/sbin/sshd  &
sleep 2

echo "=== USER PASSWORDS ==="
echo "level0: level0"
i=1
while read -r pass; do
    echo "level$i: $pass"
    i=$((i+1))
done < /tmp/pass.txt
echo "======================"
echo

echo "=== Docker Socket Debug ==="
if [ -S /var/run/docker.sock ]; then
    ls -la /var/run/docker.sock
    DOCKER_GID=$(stat -c %g /var/run/docker.sock)
    echo "Docker socket GID: $DOCKER_GID"

    if ! getent group docker >/dev/null; then
        addgroup -g $DOCKER_GID docker
    else
        groupmod -g $DOCKER_GID docker 2>/dev/null || echo "Could not change docker group GID"
    fi

    for i in $(seq 0 2); do
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

    echo "Starting level containers..."
    for i in $(seq 0 2); do
        echo "Starting level${i} container..."
        if docker run -d --name level${i}-container child-level${i} 2>/dev/null; then
            echo "✓ level${i} container started"
        else
            echo "✗ level${i} container failed to start (may already exist)"
            docker start level${i}-container 2>/dev/null && echo "  → level${i} container restarted"
        fi
    done
else
    echo "✗ Docker daemon not accessible"
fi

tail -f /dev/null
