#!/bin/bash
echo "Starting SSH daemon..."
/usr/sbin/sshd &
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

echo "=== Configuring Docker Permissions ==="
if [ -S /var/run/docker.sock ]; then
    # Get the Group ID (GID) of the Docker socket
    DOCKER_GID=$(stat -c %g /var/run/docker.sock)
    echo "Docker socket found with GID: $DOCKER_GID"

    # Create a 'docker' group with the correct GID if it doesn't exist
    if ! getent group docker >/dev/null; then
        echo "Creating docker group with GID $DOCKER_GID..."
        addgroup -g $DOCKER_GID docker
    else
        echo "Docker group already exists. Ensuring GID is correct."
        groupmod -g $DOCKER_GID docker
    fi

    # Add all 'level' users to the 'docker' group so they can run docker-compose
    for i in $(seq 0 16); do
        echo "Adding level$i to docker group..."
        adduser level$i docker
    done
else
    echo "ERROR: Docker socket not found at /var/run/docker.sock."
    echo "Please ensure the Docker socket is mounted correctly into this container."
fi

# We have also removed the Docker access test as it's not necessary here.
# The user-specific environments will be created on-demand.

echo "Setup complete. The system is ready to route user sessions."
echo "Waiting for SSH connections..."
tail -f /dev/null
