#!/bin/bash

# add google repos
sudo cat>/etc/yum.repos.d/google.repo<<'EOF'
[google]
name=Google - $basearch
baseurl=http://dl.google.com/linux/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

sudo cat>/etc/yum.repos.d/google-chrome.repo<<'EOF'
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

# Download and install install_chrome.sh
# http://tecadmin.net/install-google-chrome-in-centos-rhel-and-fedora/#
cd /tmp

#git clone https://github.com/khilnani/devops/blob/master/centos/install_chrome.sh
wget http://chrome.richardlloyd.org.uk/install_chrome.sh
chmod a+x install_chrome.sh
sudo ./install_chrome.sh


