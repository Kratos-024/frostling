FROM alpine:latest

RUN apk add --no-cache bash file

RUN adduser -D -s /bin/bash level5 && \
    echo "level5:isVd2Nwipm1UGpa76cuz" | chpasswd

RUN mkdir -p /home/level5/mystery
COPY secret.bin /home/level5/mystery/

RUN chown -R level5:level5 /home/level5

RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

USER level5
WORKDIR /home/level5

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
