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
PHP_VERSION ?= 8.1
WITH ?= ''
build: ## Build docker image
	docker build --force-rm --tag symfony-cli . --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg WITH=$(WITH)

remove: ## Remove docker image
	@container=$(docker images symfony-cli -a -q)
	@[ "${container}" ]  && docker rmi $(container) || echo "No container to remove"

TAG ?= 8.1-minimalist
tag: ## Tag docker image
	docker tag symfony-cli raneomik/symfony-cli:$(TAG)

push: ## Push docker image
	docker push raneomik/symfony-cli:$(TAG)
