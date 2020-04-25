FROM edbizarro/gitlab-ci-pipeline-php:7.4

USER root

WORKDIR /tmp

COPY ./common/*.sh /tmp/

RUN bash ./packages.sh

RUN bash ./cleanup.sh

USER $IMAGE_USER

WORKDIR /var/www/html
