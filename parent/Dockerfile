FROM alpine:latest

RUN apk add --no-cache openssh bash curl sudo shadow && \
    curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.21.tgz | \
    tar -xzC /usr/local/bin --strip-components=1 docker/docker

# Configure SSH
RUN ssh-keygen -A && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# Create level0 with password level0
RUN adduser -D -s /bin/bash level0 && \
    echo "level0:level0" | chpasswd

# Create all other users with their specific passwords
RUN adduser -D -s /bin/bash level1 && echo "level1:mGEGXumwICmohV" | chpasswd && \
    adduser -D -s /bin/bash level2 && echo "level2:6l8i8me0M2KNaTo" | chpasswd && \
    adduser -D -s /bin/bash level3 && echo "level3:bx4U8R6vdAWquk" | chpasswd && \
    adduser -D -s /bin/bash level4 && echo "level4:aIZ0qLVAV05SuyDV52L" | chpasswd && \
    adduser -D -s /bin/bash level5 && echo "level5:isVd2Nwipm1UGpa76" | chpasswd && \
    adduser -D -s /bin/bash level6 && echo "level6:nAJXOSOB7qRPqpky4V" | chpasswd && \
    adduser -D -s /bin/bash level7 && echo "level7:5lAUBEtWroOKUAlgQ" | chpasswd && \
    adduser -D -s /bin/bash level8 && echo "level8:D0fZZfMZYdm" | chpasswd && \
    adduser -D -s /bin/bash level9 && echo "level9:gJEM0aYf5GHFR" | chpasswd && \
    adduser -D -s /bin/bash level10 && echo "level10:1A838d3lyUHUicrZNZOfs" | chpasswd && \
    adduser -D -s /bin/bash level11 && echo "level11:dFl2rga6Ej0KowqvZd05" | chpasswd && \
    adduser -D -s /bin/bash level12 && echo "level12:bVTtoT252P67FMSo3Ru" | chpasswd && \
    adduser -D -s /bin/bash level13 && echo "level13:FvY2xYp9monYNxsmbKMozV5" | chpasswd && \
    adduser -D -s /bin/bash level14 && echo "level14:WfjrA4M9sXDBvZnw" | chpasswd && \
    adduser -D -s /bin/bash level15 && echo "level15:AtBsNLlVEwSs" | chpasswd && \
    adduser -D -s /bin/bash level16 && echo "level16:VR51lPJKJNgQv5b" | chpasswd && \
    adduser -D -s /bin/bash level17 && echo "level17:dN6464qHSTCeUsdE" | chpasswd && \
    adduser -D -s /bin/bash level18 && echo "level18:J5P64sYWsSTCeUpeYk5p" | chpasswd && \
    adduser -D -s /bin/bash level19 && echo "level19:Dcx3HGnczGjsjjr4E5e" | chpasswd && \
    adduser -D -s /bin/bash level20 && echo "level20:Iif2sYWsjszcB5rDSuA" | chpasswd && \
    adduser -D -s /bin/bash level21 && echo "level21:M4eXP9Q6zgUQS1T8mYpeYk5prd" | chpasswd

# Give wheel sudo access to docker
RUN echo '%wheel ALL=(ALL) NOPASSWD: /usr/local/bin/docker' >> /etc/sudoers && \
    for i in $(seq 0 21); do adduser "level$i" wheel; done

# Replace shells with router
COPY level-router.sh /usr/local/bin/
COPY start.sh /start.sh
RUN chmod +x /usr/local/bin/level-router.sh /start.sh && \
    for i in $(seq 0 21); do \
        sed -i "s|level$i:/bin/bash|level$i:/usr/local/bin/level-router.sh|" /etc/passwd; \
    done

EXPOSE 22
CMD ["/start.sh"]
