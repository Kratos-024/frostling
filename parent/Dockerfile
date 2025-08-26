FROM alpine:latest

RUN apk add --no-cache openssh bash curl sudo shadow && \
    curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.21.tgz | \
    tar -xzC /usr/local/bin --strip-components=1 docker/docker

RUN ssh-keygen -A && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

RUN for i in $(seq 0 20); do \
        adduser -D -s /bin/bash "level$i" && \
        echo "level$i:level$i" | chpasswd; \
    done

RUN echo '%wheel ALL=(ALL) NOPASSWD: /usr/local/bin/docker' >> /etc/sudoers && \
    for i in $(seq 0 20); do \
        adduser "level$i" wheel; \
    done

COPY level-router.sh /usr/local/bin/
COPY start.sh /start.sh
RUN chmod +x /usr/local/bin/level-router.sh /start.sh

RUN for i in $(seq 0 20); do \
        sed -i "s|level$i:/bin/bash|level$i:/usr/local/bin/level-router.sh|" /etc/passwd; \
    done

EXPOSE 22
CMD ["/start.sh"]