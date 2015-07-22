#!/bin/bash
set -e
cd `dirname $0`

# Install ssh keys

if [[ ! -z $ID_RSA ]]; then
	echo "Installing id_rsa"
	echo $ID_RSA | base64 -d > ~/.ssh/id_rsa
	chmod 600 ~/.ssh/id_rsa
fi
if [[ ! -z $ID_RSA_PUB ]]; then
	echo "Installing id_rsa.pub"
	echo $ID_RSA_PUB | base64 -d > ~/.ssh/id_rsa.pub
	chmod 644 ~/.ssh/id_rsa.pub
fi

# Install docker
# (Should be part of Dockerfile)

if which docker > /dev/null; then
	echo "docker already installed"
else
	echo "Installing docker"
	export DEBIAN_FRONTEND=noninteractive
	apt-get update
	apt-get install docker.io
fi

service docker.io start
docker info

# Configure env

if test -e /artifacts; then
	export CIRCLE_ARTIFACTS=/artifacts
fi

# Checkout or update git

if test -e triominos-client; then
	cd triominos-client
	git pull
else
	git clone git@github.com:j3k0/triominos-client.git
	cd triominos-client
	git submodule init
fi

# Get submodules
git submodule update

# Prepare tests
./pre-test.sh

# Test
#./test.sh (fails)

# Prepare pacakge
./pre-package.sh

# Package
./package.sh

