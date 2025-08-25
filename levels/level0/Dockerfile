FROM alpine:latest

RUN apk add --no-cache bash

RUN adduser -D -s /bin/bash level0 && \
    echo "level0:mGE$GX{#umwI%C[mohV(" | chpasswd

COPY welcome.txt instructions.txt password.txt /home/level0/

RUN chown -R level0:level0 /home/level0

RUN chmod 700 /home \
    && chmod 500 /home/level0 \
    && chmod 444 /home/level0/*

USER level0
WORKDIR /home/level0

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
