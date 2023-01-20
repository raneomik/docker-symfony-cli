.DEFAULT_GLOBAL = help
SHELL:=/bin/bash

.PHONY: help

help: ## Show this help hint
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'


##-------------------
## Git :
git-tag: ## Update tag on git repository
	git push origin :refs/tags/$(TAG)
	git tag -fa $(TAG)
	git push -f --tags

##-------------------
## Docker :
PHP_VERSION ?= 8.2
WITH_APK ?= ''
WITH_ENABLED_EXT ?= ''
build: ## Build docker image
	docker build --force-rm --tag symfony-cli . --build-arg PHP_VERSION=$(PHP_VERSION) \
 	--build-arg WITH_APK=$(WITH_APK) \
 	--build-arg WITH_ENABLED_EXT=$(WITH_ENABLED_EXT)

remove: ## Remove docker image
	@container=$(docker images symfony-cli -a -q)
	@[ "${container}" ] && docker rmi $(container) || echo "No container to remove"

TAG ?= 8.2-minimalist
DOCKERHUB_USERNAME ?= devchoosit
tag: ## Tag docker image
	docker tag symfony-cli $(DOCKERHUB_USERNAME)/symfony-cli:$(TAG)

push: ## Push docker image
	docker push $(DOCKERHUB_USERNAME)/symfony-cli:$(TAG)
