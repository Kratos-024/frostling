FROM alpine:latest

RUN apk add --no-cache bash

RUN adduser -D -s /bin/bash level1 && \
    echo "level1:mGEGXumwICmohV" | chpasswd

RUN mkdir -p /home/level1/onichan
COPY password.txt /home/level1/onichan/

RUN chown -R level1:level1 /home/level1


RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

USER level1
WORKDIR /home/level1

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
