#!/usr/bin/env bash

curl https://get.symfony.com/cli/installer -o - | bash
mv /home/$IMAGE_USER/.symfony/bin/symfony /usr/local/bin/symfony

apt-get update && apt-get upgrade
apt-get install java

pecl install grpc && docker-php-ext-enable grpc