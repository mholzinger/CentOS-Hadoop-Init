#!/bin/bash

#system-config-network
service network restart
sudo ifup eth0
sudo ifup eth1
