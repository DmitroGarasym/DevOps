#!/bin/bash

# Create user “adminuser”
useradd adminuser

# Set password for “adminuser”
echo 'adminuser:secret' | sudo chpasswd

# Create group admin
groupadd admin

echo '%admin ALL=(ALL:ALL) ALL' >> /etc/sudoers

# Grant for “adminuser” sudoer permission
usermod -a -G admin adminuser

# Create user “poweruser”
useradd poweruser

# Grant for “poweruser” permission for iptables command
echo 'poweruser ALL=(ALL:ALL) /usr/sbin/iptables' >> /etc/sudoers

# Allow “poweruser” to read home directory of “adminuser” 
usermod -a -G adminuser poweruser

# List all of files with SUID bit set
find / -type d -perm 4000 -exec ls -ld {} \; 1>> /var/suid_files.txt 2> /dev/null
