#!/usr/bin/env bash

curl https://get.symfony.com/cli/installer -o - | bash
mv /home/$IMAGE_USER/.symfony/bin/symfony /usr/local/bin/symfony

apk --update --no-cache add linux-headers libstdc++ musl php7-common

pecl install grpc && docker-php-ext-enable grpc