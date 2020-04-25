FROM edbizarro/gitlab-ci-pipeline-php:7.3-alpine

USER root

WORKDIR /tmp

COPY ./common/alpine/*.sh /tmp/

RUN apk add --update --no-cache bash \
RUN bash ./packages.sh

RUN bash ./cleanup.sh

USER $IMAGE_USER

WORKDIR /var/www/html
