FROM php:8.1-alpine

RUN apk --update --no-cache add locales apt-utils git libicu-dev g++ libpng-dev libxml2-dev libzip-dev libonig-dev libxslt-dev \
 && docker-php-ext-configure intl \
 && docker-php-ext-install pdo pdo_mysql gd opcache intl zip calendar dom mbstring zip gd xsl

pecl install apcu \
 && docker-php-ext-enable apcu

pecl install pcov \
 && docker-php-ext-enable pcov

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
