#!/bin/bash
yum install -y epel-release
yum install -y nginx
   
rm -fr /usr/share/nginx/html/*
cp -rav /vagrant/www-content/* /usr/share/nginx/html
  
setenforce 0
systemctl start nginx
systemctl enable nginx