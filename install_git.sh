#!/bin/bash

# TODO: Use curl to grab the latest version string for git

# current version 1.9.1
GIT_MAJOR=1.9
GIT_MINOR=1
GIT_VER=$GIT_MAJOR.$GIT_MINOR

# TODO: Run as root

yum install gettext-devel expat-devel curl-devel zlib-devel openssl-devel
cd /usr/local/src
wget https://www.kernel.org/pub/software/scm/git/git-$GIT_VER.tar.gz
tar xzvf git-$GIT_VER.tar.gz
cd git-$GIT_VER
make prefix=/usr/local all
make prefix=/usr/local install

