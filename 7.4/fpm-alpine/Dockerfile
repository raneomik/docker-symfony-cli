FROM php:7.4-fpm-alpine

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Marek Necesanny <marek_necesany@hotmail.fr" \
  PHP="7.4" \
  NODE="12" \
  org.label-schema.name="raneomik/symfony-cli" \
  org.label-schema.description="Docker images for build and test PHP applications with Gitlab CI (or any other CI plataform!)" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vcs-url="https://github.com/mramik/docker-symfony-cli" \
  org.label-schema.vcs-ref=$VCS_REF

# Set correct environment variables
ENV IMAGE_USER=php
ENV HOME=/home/$IMAGE_USER
ENV COMPOSER_HOME=$HOME/.composer
ENV PATH=$HOME/.yarn/bin:$PATH
ENV GOSS_VERSION=0.3.8
ENV NODE_VERSION=12
ENV YARN_VERSION=latest
ENV PHP_VERSION=7.4

WORKDIR /tmp

# Composer
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer

# COPY INSTALL SCRIPTS
COPY ./common/alpine/*.sh /tmp/

RUN chmod +x /tmp/*.sh \
  && adduser -D $IMAGE_USER \
  && mkdir -p /var/www/html \
  && apk add --update --no-cache bash \
  && bash ./extensions.sh \
  && composer global require "hirak/prestissimo:^0.3" \
  && rm -rf ~/.composer/cache/* \
  && chown -R $IMAGE_USER:$IMAGE_USER /var/www $HOME \
  && echo "$IMAGE_USER  ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
  && curl -fsSL https://goss.rocks/install | GOSS_VER=v${GOSS_VERSION} sh \
  && bash ./packages.sh \
  && bash ./cleanup.sh

# Node & Yarn
COPY --from=mhart/alpine-node:12 /usr/bin/node /usr/bin/
COPY --from=mhart/alpine-node:12 /usr/lib/libgcc* /usr/lib/libstdc* /usr/lib/* /usr/lib/

RUN ln -s /usr/lib/npm/bin/npm-cli.js /usr/bin/npm \
    && curl -o- -L https://yarnpkg.com/install.sh | bash \
    && mkdir $HOME/.config \
    && rm -rf /usr/share/man /var/cache/apk/* \
      /root/.npm /root/.node-gyp /root/.gnupg /usr/lib/node_modules/npm/man \
      /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts

USER $IMAGE_USER

WORKDIR /var/www/html

CMD ["php", "-a"]
