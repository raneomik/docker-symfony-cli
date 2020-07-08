#!/usr/bin/env bash

apt-get update && apt-get upgrade

curl https://get.symfony.com/cli/installer -o - | bash
mv $HOME/.symfony/bin/symfony /usr/local/bin/symfony

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    yes | sdk install java && \
    rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/*
ln -sf $HOME/.sdkman/candidates/java/current/bin/java /usr/local/bin/java

export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export PATH="$JAVA_HOME/bin:$PATH"

chown -R $IMAGE_USER:$IMAGE_USER $HOME

pecl install grpc && docker-php-ext-enable grpc