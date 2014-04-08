#!/bin/bash

yum install gettext-devel expat-devel curl-devel zlib-devel openssl-devel
cd /usr/local/src
wget https://www.kernel.org/pub/software/scm/git/git-1.8.2.3.tar.gz
tar xzvf git-1.8.2.3.tar.gz
cd git-1.8.2.3
make prefix=/usr/local all
make prefix=/usr/local install
