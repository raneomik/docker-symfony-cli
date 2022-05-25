.DEFAULT_GLOBAL = help
SHELL:=/bin/bash

help: ## Show this help hint
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##---------------
## GIT
##
tag-update:
	git push origin :refs/tags/$(TAG)
	git tag -fa $(TAG)
	git push -f --tags

##---------------
## Docker
##
DIR ?= minimalist
VERSION ?= 8.1
build:
	docker build -f $(DIR)/Dockerfile --force-rm --tag symfony-cli . --build-arg VERSION=$(VERSION)

tag:
	docker tag symfony-cli raneomik/symfony-cli:$(TAG)

push:
	docker push raneomik/symfony-cli:$(TAG)

