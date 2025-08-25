FROM alpine:latest

RUN apk add --no-cache bash

RUN adduser -D -s /bin/bash level1 && \
    echo "level1:6l8i{8m(e0M2KNa$To" | chpasswd

RUN mkdir -p /home/level1/onichan
COPY password.txt /home/level1/onichan/

RUN chown -R level1:6l8i{8m(e0M2KNa$To /home/level1


RUN find /home -type d -exec chmod 555 {} \; \
    && find /home -type f -exec chmod 444 {} \;

USER level1
WORKDIR /home/level1

CMD ["/bin/bash", "-c", "tail -f /dev/null"]
