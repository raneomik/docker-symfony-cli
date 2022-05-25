#!/bin/bash

latestRelease() {
  git ls-remote --tags "$1" |
  cut -d/ -f3-  |
  grep -v "{}" |
  tail -n1 |
  cut -c 2-;
}

previousVersion() {
  echo "$1" |
  awk -F. -v OFS=. '{$NF -= 1 ; print}'
}

check() {
  status=$(curl --write-out %{http_code} --silent --output /dev/null "https://github.com/symfony-cli/symfony-cli/releases/download/$1.tar.gz")
  [[ "$status" -eq 200 ]]
}

download() {
  URL="https://github.com/symfony-cli/symfony-cli/releases/download/$1.tar.gz"
  echo "Downloading from $URL"
  curl -L "$URL" | tar xz symfony
}

LATEST=$(latestRelease https://github.com/symfony-cli/symfony-cli)

MACHINE=$([ 'i386' = "$(uname -m)" ] && echo "386" || echo "amd64" )
PACKAGE="v${LATEST}/symfony-cli_linux_${MACHINE}"

if ! (( $(check "${PACKAGE}") )) ; then
  LATEST=$(previousVersion "${LATEST}")
  PACKAGE="v${LATEST}/symfony-cli_linux_${MACHINE}"
fi

download "$PACKAGE"
