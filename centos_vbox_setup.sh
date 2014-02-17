#!/bin/bash

mkdir ~/bin
cat>~/bin/amiup<<'EOF'
#!/bin/bash

ping_internets() {
	ping -c 2 google.com > /dev/null 2>&1

	check_err "Nope - google.com is not reachable. No internets for you :["

	# if we have a 0 exit status for ping we report this
	echo "Yay! google.com is reachable. You're online!"
}

check_err(){ error_state=$(echo $?)
if [[ "$error_state" != "0" ]];then
    echo $1
    exit
fi
}

ping_internets
EOF

chmod a+x ~/bin/amiup

# User specific aliases and functions
echo "PS1='\[\033[02;32m\]\u@\H:\[\033[02;34m\]\w\$\[\033[00m\] '" >> ~/.bashrc
echo "export PATH="$HOME/bin:$PATH"" >> ~/.bashrc

# Add current user to /etc/sudoers
currentuser=$( whoami )
su -c "echo '$currentuser  ALL=(ALL:ALL) ALL' >> /etc/sudoers"

# Setup python dependencies
sudo easy_install pexpect

# Use python pexpect to generate ssh keys
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

sudo rm -f /etc/udev/rules.d/70-persistent-net.rules

system-config-network
service network restart

# Install rpmforge packages
cd /tmp
wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm
sudo rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm

# Install HTOP
sudo yum -y install htop

