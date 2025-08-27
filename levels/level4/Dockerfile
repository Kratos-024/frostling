FROM alpine:latest

RUN apk add --no-cache bash

# Create user and set password
RUN adduser -D -s /bin/bash level4 && \
    echo "level4:aIZ0qLVAV05SuyDV52L" | chpasswd

# Copy your prepared directories from the build context
COPY level4_home /home/level4/level4_home

# Copy any extra files if needed
COPY password.txt /home/level4/level4_home/folder5_1/folder4_3/folder3_3/folder2_2/folder1_3

# Fix ownership
RUN chown -R level4:level4 /home/level4

# Set permissions (optional)
RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

USER level4
WORKDIR /home/level4

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
