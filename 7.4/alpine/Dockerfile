FROM edbizarro/gitlab-ci-pipeline-php:7.4-alpine

USER root

WORKDIR /tmp

COPY ./common/alpine/*.sh /tmp/

RUN bash ./packages.sh

RUN bash ./cleanup.sh

USER $IMAGE_USER

WORKDIR /var/www/html
