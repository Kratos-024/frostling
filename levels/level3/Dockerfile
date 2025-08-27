FROM alpine:latest

RUN apk add --no-cache bash

RUN adduser -D -s /bin/bash level3 && \
    echo "level3:bx4U8R6vdAWquk" | chpasswd

RUN mkdir -p /home/level3/logs
COPY logfile.txt /home/level3/logs/

RUN chown -R level3:level3 /home/level3

RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

USER level3
WORKDIR /home/level3

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
