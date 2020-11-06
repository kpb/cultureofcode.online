#!/usr/bin/make
#
# Build, test, and deploy Culture of Code

# deploy vars
DEPLOY_USER = kenbow8
DEPLOY_HOST = blackandwhitemartini.com

BUILD_DIR = public

.DEFAULT_GOAL := help

.PHONY: build
build: ## Build the site.
	hugo

.PHONY: try
try: ## Build the site and run a local server on localhost:1313.
	hugo server -vw

.PHONY: deploy
deploy: build ## Build and deploy site to production web server.
	rsync -avz --exclude-from .rsyncignore -e ssh --delete $(BUILD_DIR)/ $(DEPLOY_USER)@$(DEPLOY_HOST):cultureofcode.com

# clean up the build
.PHONY: clean
clean: ## Delete the build directory
	rm -rf $(BUILD_DIR)

# Thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Display help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
# add | sort | before | awk... for alphabetical order
