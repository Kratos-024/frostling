#!/bin/bash
# Start SSH
/usr/sbin/sshd &

for i in {0..20}; do
    docker run -d --name level${i}-container ctf-level${i}
done

wait
