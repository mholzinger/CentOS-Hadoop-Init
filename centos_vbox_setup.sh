#!/bin/bash

# User specific aliases and functions
echo "PS1='\[\033[02;32m\]\u@\H:\[\033[02;34m\]\w\$\[\033[00m\] '" >> ~/.bashrc
echo "export PATH="$HOME/bin:$PATH"" >> ~/.bashrc
mkdir ~/bin

# Add current user to /etc/sudoers
currentuser=$( whoami )
su -c "echo '$currentuser  ALL=(ALL:ALL) ALL' >> /etc/sudoers"

# setup python dependencies
sudo easy_install pexpect

# use python to generate ssh keys
python - <<END
#!/usr/bin/python
 
import pexpect
 
child = pexpect.spawn('ssh-keygen  -t rsa -b 2048')
child.expect('Generating')
child.expect('Enter file in which to save the key')
child.sendline('\n')
child.expect('Created directory')
child.expect('Enter passphrase')
child.sendline('\n')
child.expect('Enter same passphrase again')
child.sendline('\n')
END

# Stop NetworkManager service
sudo service NetworkManager stop

# Configure chkconfig so that the NetworkManager service cannot start at startup
sudo chkconfig NetworkManager off

# Add default Net Manager
sudo chkconfig network on

# Sudo yum -y uninstall NetworkManager
sudo rm -f /etc/udev/rules.d/70-persistent-net.rules

system-config-network
service network restart

# Install htop
cd /tmp
wget http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/RPMS/htop-0.9-1.el6.rf.x86_64.rpm
sudo rpm -i htop-0.9-1.el6.rf.x86_64.rpm


