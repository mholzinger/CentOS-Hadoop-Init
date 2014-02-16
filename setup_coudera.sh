#!/bin/bash

# Disable SELinux
sudo sed -i.backup -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# placeholder code for stopping service without rebooting

# grab and install cloudera components
cd /tmp
wget http://archive.cloudera.com/cm4/installer/latest/cloudera-manager-installer.bin
chmod u+x cloudera-manager-installer.bin
sudo ./cloudera-manager-installer.bin

# login with admin:admin
firefox  http://localhost:7180

# restart cloudera service
sudo service cloudera-scm-server restart

# login with admin:admin
firefox  http://localhost:7180

