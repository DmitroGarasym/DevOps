#!/bin/bash

# create user “adminuser”
useradd adminuser

# set password for “adminuser”
 echo "linuxpassword" | passwd --stdin adminuser

# Create group admin
groupadd lnxadmin

echo '%lnxadmin ALL=(ALL:ALL) ALL' >> /etc/sudoers

# Grant for “adminuser” sudoer permission
usermod -a -G lnxadmin adminuser

# create user “poweruser”
useradd poweruser

# grant for “poweruser” permission for iptables command
echo 'poweruser ALL=(ALL:ALL) /usr/sbin/iptables' >> /etc/sudoers

# Allow “poweruser” to read home directory of “adminuser” 
usermod -a -G adminuser poweruser

# List all of files with SUID bit set
find / -type d -perm 4000 -exec ls -ld {} \;
