FROM alpine:latest

RUN apk add --no-cache bash

RUN adduser -D -s /bin/bash level8 && \
    echo "level8:gJEM0aYf5GHFR" | chpasswd

# Create multiple directories with decoy and real files
RUN mkdir -p /home/level8/documents/old \
    /home/level8/documents/new \
    /home/level8/backup/2024 \
    /home/level8/backup/2025 \
    /home/level8/temp

# Copy multiple files - some decoys, one real password
COPY fake_pass1.txt /home/level8/documents/old/
COPY fake_pass2.txt /home/level8/documents/new/
COPY decoy.txt /home/level8/backup/2024/
COPY real_password.txt /home/level8/backup/2025/
COPY junk.txt /home/level8/temp/

RUN chown -R level8:level8 /home/level8

RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

USER level8
WORKDIR /home/level8

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
