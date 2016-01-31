FROM docker

RUN apk add --no-cache bash

ADD docker-container-cleanup.sh /usr/libexec/docker-container-cleanup.sh

ENV THRESHOLD=85

ENV SLEEP=30

CMD /usr/libexec/docker-container-cleanup.sh
