FROM jenkinsci/blueocean:latest

USER root
RUN apk update \
    && apk add py-pip python-dev libffi-dev openssl-dev gcc libc-dev make
RUN pip install docker-compose
