ARG PHP_VERSION
FROM php:${PHP_VERSION}-alpine

WORKDIR /tmp

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
  rsync

RUN curl -o /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar \
  && chmod +x /usr/local/bin/composer

COPY fetch-symfony-cli.sh /tmp/
RUN bash ./fetch-symfony-cli.sh
RUN mv /tmp/symfony /usr/local/bin/symfony \
    && chmod +x /usr/local/bin/symfony

RUN docker-php-ext-configure intl \
  && docker-php-ext-install -j "$(nproc)" \
  pdo \
  pdo_mysql \
  gd \
  opcache \
  intl \
  zip \
  calendar \
  dom \
  mbstring \
  zip \
  gd \
  xsl \
  soap \
  sockets \
  exif

RUN docker-php-source extract \
    && apk add --no-cache --virtual .phpize-deps-configure $PHPIZE_DEPS

ARG WITH_BASE_ENABLED_EXT="apcu pcov"
ARG WITH_ENABLED_EXT
ARG WITH_ENABLED_EXT_LIST="$WITH_BASE_ENABLED_EXT $WITH_ENABLED_EXT"

ARG WITH_APK

RUN if [ "$WITH_APK" ]; then apk --update --no-cache add $WITH_APK; fi \
    && pecl install $WITH_ENABLED_EXT_LIST  \
    && docker-php-ext-enable $WITH_ENABLED_EXT_LIST

RUN echo "memory_limit=1G" > /usr/local/etc/php/conf.d/zz-conf.ini

RUN  apk del .phpize-deps-configure \
    && docker-php-source delete \
    && rm -rf /tmp/* \
        /usr/includes/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/*

