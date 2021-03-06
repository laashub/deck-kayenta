#!/bin/bash
# This script will install the project.

NODE_JS_VERSION=`node -e 'console.log(require("./package.json").engines.node.replace(/[^\d\.]/g, ""))'`;
echo -e "Installing/activating node v$NODE_JS_VERSION"

# http://austinpray.com/ops/2015/09/20/change-travis-node-version.html
# Clear out whatever version of NVM Travis has. ; Their version of NVM is probably old.
rm -rf ~/.nvm
git clone https://github.com/creationix/nvm.git ~/.nvm

# Checkout the latest stable nvm tag.
(cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`)

source ~/.nvm/nvm.sh

nvm install $NODE_JS_VERSION
# Travis installs yarn v1.3.2 for some reason, but we want a recent version
npm install -g yarn@1.21.1
yarn --frozen-lockfile
