FROM alpine:latest

RUN apk add --no-cache bash

# Add user
RUN adduser -D -s /bin/bash level2 && \
    echo "level2:6l8i8me0M2KNaTo" | chpasswd

# Create directories and copy files
RUN mkdir -p /home/level2/noPasswordGoAway
COPY password.txt /home/level2/noPasswordGoAway/

# Change ownership
RUN chown -R level2:level2 /home/level2

# Set permissions:
# All directories in /home: read+execute (no write)
# All files: read-only
RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

# Switch to user
USER level2
WORKDIR /home/level2

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
