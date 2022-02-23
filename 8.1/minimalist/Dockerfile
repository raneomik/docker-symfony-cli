FROM php:8.1-alpine

RUN apk --update --no-cache add \
  git \
  bash \
  libintl \
  icu-dev \
  zlib-dev \
  libpng-dev \
  sqlite-dev \
  libzip-dev \
  libxml2-dev \
  libxslt-dev \
  oniguruma-dev \
  openssh-client \
  rsync \
  && docker-php-ext-configure intl \
  && docker-php-ext-install -j "$(nproc)" pdo pdo_mysql gd opcache intl zip calendar dom mbstring zip gd xsl \
  && docker-php-ext-install soap

RUN docker-php-source extract \
    && apk add --no-cache --virtual .phpize-deps-configure $PHPIZE_DEPS \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && pecl install pcov \
    && docker-php-ext-enable pcov \
    && apk del .phpize-deps-configure \
    && docker-php-source delete

RUN curl -o /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar \
  && chmod +x /usr/local/bin/composer

RUN curl https://get.symfony.com/cli/installer -o - | bash \
 && mv $HOME/.symfony/bin/symfony /usr/local/bin/symfony

RUN docker-php-source delete \
 && rm -rf /tmp/* \
        /usr/includes/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/*

RUN echo "memory_limit=1G" > /usr/local/etc/php/conf.d/zz-conf.ini \
