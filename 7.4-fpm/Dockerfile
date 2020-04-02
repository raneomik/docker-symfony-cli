FROM edbizarro/gitlab-ci-pipeline-php:7.4-fpm

USER root

RUN curl https://get.symfony.com/cli/installer -o - | bash
RUN mv /home/$IMAGE_USER/.symfony/bin/symfony /usr/local/bin/symfony

RUN apt-get update \
    && apt-get upgrade

RUN pecl install grpc \
    && docker-php-ext-enable grpc

RUN apt-get purge -yqq --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false \
        apt-utils \
        build-essential \
        dpkg-dev \
        file \
        libc-client-dev \
        libc-dev \
        libpcre3-dev \
        pkg-config \
        re2c

RUN apt-get autoremove -yqq --purge
RUN apt-get autoclean -yqq
RUN apt-get clean
RUN rm -rf /var/cache/apt/ /var/lib/apt/lists/* /var/log/* /tmp/* /var/tmp/* /usr/share/doc /usr/share/doc-base /usr/share/groff/* /usr/share/info/* /usr/share/linda/* /usr/share/lintian/overrides/* /usr/share/locale/* /usr/share/man/* /usr/share/locale/* /usr/share/gnome/help/*/* /usr/share/doc/kde/HTML/*/* /usr/share/omf/*/*-*.emf

USER $IMAGE_USER

WORKDIR /var/www/html
