FROM alpine:latest

RUN apk add --no-cache bash

RUN adduser -D -s /bin/bash level9 && \
    echo "level9:gJEM0aYf5GHFR" | chpasswd

RUN mkdir -p /home/level9/data
COPY firmware.bin /home/level9/data/

RUN chown -R level9:level9 /home/level9
RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

USER level9
WORKDIR /home/level9

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
