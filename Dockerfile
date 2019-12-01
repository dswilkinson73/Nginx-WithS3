FROM alpine:latest

LABEL maintainer = "David S. Wilkinson"

ENV AWSCLI_VERSION "1.16.244"

RUN apk update
RUN apk add python \
    python-dev \
    py-pip \
    build-base \
    nginx

ENV PATH="/root/.local/bin:${PATH}"

RUN pip install awscli==$AWSCLI_VERSION --upgrade --user \
