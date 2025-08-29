FROM alpine:latest

# Install required packages
RUN apk add --no-cache bash

# Create the user for the level with a standard password for SSH access
RUN adduser -D -s /bin/bash level8 && \
    echo "level8:D0fZZfMZYdm" | chpasswd

# Create the directory structure to add complexity
RUN mkdir -p /home/level8/documents/old \
    /home/level8/documents/new \
    /home/level8/backup/2024 \
    /home/level8/backup/2025 \
    /home/level8/temp

# Create several EMPTY decoy files in various locations
RUN touch /home/level8/documents/old/pass.txt \
    && touch /home/level8/documents/new/config.ini \
    && touch /home/level8/backup/2024/archive.zip \
    && touch /home/level8/temp/log.tmp

# Change ownership of the entire home directory and all its contents to the 'level8' user
RUN chown -R level8:level8 /home/level8

# NOW, as ROOT, create the real password file. It will be:
# 1. Hidden (starts with a dot)
# 2. Owned by 'root' (since this command runs as root)
# 3. Not empty (contains the flag)
RUN echo "gJEM0aYf5GHFR" > /home/level8/temp/.secret_config

# Set restrictive permissions for the challenge:
# - Directories are browsable (555)
# - All files are read-only (444)
RUN find /home/level8 -type d -exec chmod 555 {} \; \
    && find /home/level8 -type f -exec chmod 444 {} \;

# Switch to the level's user
USER level8
WORKDIR /home/level8

# Keep the container running
CMD ["/bin/bash", "-c", "tail -f /dev/null"]
