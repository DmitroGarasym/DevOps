#!/bin/bash

#find names of all soft-links on VM
find / -type l -ls 

#find count of block and character devices
find / -type c -or -type b | wc -l 

#find all folders with Sticky bit
find / -type d -perm /1000 -ls >> 

#make soft link for /etc/hostname in /tmp folder
ln -s /etc/hostname /tmp/link

#create user “testuser”
useradd testuser

#create file in home directory “testuser_data” owned by “testuser”
sudo -u testuser touch "/home/testuser/testuser_data"
