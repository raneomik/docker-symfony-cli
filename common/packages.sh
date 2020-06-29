#!/usr/bin/env bash

curl https://get.symfony.com/cli/installer -o - | bash
mv /home/$IMAGE_USER/.symfony/bin/symfony /usr/local/bin/symfony

apt-get update && apt-get upgrade

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    yes | sdk install java && \
    rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/*

JAVA_HOME="/home/$IMAGE_USER/.sdkman/candidates/java/current"
PATH="$JAVA_HOME/bin:$PATH"

pecl install grpc && docker-php-ext-enable grpc