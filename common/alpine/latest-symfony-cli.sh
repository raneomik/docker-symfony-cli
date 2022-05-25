#!/usr/bin/env bash

latestRelease() {
  git ls-remote --tags "$1" |
  cut -d/ -f3-  |
  grep -v "{}" |
  tail -n1 |
  cut -c 2-;
}

previousVersion() {
  echo $1 |
  awk -F. -v OFS=. '{$NF -= 1 ; print}'
}

download() {
  URL="https://github.com/symfony-cli/symfony-cli/releases/download/$1"
  echo "Downloading from $URL"
  curl -L $URL | tar xvz
}

MACHINE=$([ 'i386' = `uname -m` ] && echo "386" || echo "amd64" )
LATEST=$(latestRelease https://github.com/symfony-cli/symfony-cli)
PACKAGE=v${LATEST}/symfony-cli_linux_${MACHINE}.tar.gz

status_code=$(curl --write-out %{http_code} --silent --output /dev/null "https://github.com/symfony-cli/symfony-cli/releases/download/$PACKAGE")

if [[ "$status_code" -ne 200 ]] ; then
  LATEST=$(previousVersion $LATEST)
  PACKAGE=v${LATEST}/symfony-cli_linux_${MACHINE}.tar.gz
fi

download $PACKAGE
