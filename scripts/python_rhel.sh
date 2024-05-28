#!/bin/bash

# Custom diagnostics setup script

# Ensure Python is installed
cd /

#For Red Hat
sudo yum install python2
sudo update-alternatives --remove-all python
sudo ln -sf /bin/python2 /bin/python

# Install any necessary packages or configurations for diagnostics
# Example: Install sysstat for performance monitoring
#sudo apt-get install -y sysstat

#sudo yum makecache
#sudo yum -y install policycoreutils-python-utils
sudo dnf makecache
sudo dnf -y install policycoreutils-python-utils



