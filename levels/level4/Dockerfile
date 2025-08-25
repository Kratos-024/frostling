FROM alpine:latest

RUN apk add --no-cache bash

# Create user and set password
RUN adduser -D -s /bin/bash level4 && \
    echo "level4:isVd2N&wipm)1UGpa76" | chpasswd

# Copy your prepared directories from the build context
COPY level4_home /home/level4/level4_home

# Copy any extra files if needed
COPY password.txt /home/level4/level4_home/folder1_2/folder2_2/folder3_2/folder4_2/

# Fix ownership
RUN chown -R level4:isVd2N&wipm)1UGpa76 /home/level4

# Set permissions (optional)
RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

USER level4
WORKDIR /home/level4

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
