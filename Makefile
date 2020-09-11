#!/usr/bin/make
#
# Deploy Culture of Code

# deploy vars
DEPLOY_USER = kenbow8
DEPLOY_HOST = blackandwhitemartini.com

BUILD_DIR = public

# TODO build and serve targets

# build the site
.PHONY: build
build:
	hugo

# clean up the build
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

# run a local server on the site
.PHONY: try
try:
	hugo server -vw

# Deploy to prod
.PHONY: deploy
deploy: build
	rsync -avz --exclude-from .rsyncignore -e ssh --delete $(BUILD_DIR)/ $(DEPLOY_USER)@$(DEPLOY_HOST):cultureofcode.com
