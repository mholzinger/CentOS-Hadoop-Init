#!/bin/bash

# Test for SELinux disabled
SESTAT=$( getenforce )
S2='Disabled'
if [ "$SESTAT" != "$S2" ];
    then
    echo "SELinux is ('$SESTAT') - set to ('$S2') and reboot"
    exit
fi

# Grab and install cloudera components
cd /tmp
wget http://archive.cloudera.com/cm4/installer/latest/cloudera-manager-installer.bin
chmod u+x cloudera-manager-installer.bin
sudo ./cloudera-manager-installer.bin

# At this point the installer launches a firefox browser at :7180 before the service has started 

# Restart cloudera service
sudo service cloudera-scm-server restart

# Login with admin:admin
firefox  http://localhost:7180 &

