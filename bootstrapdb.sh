#!/bin/bash
sudo su
dnf install mariadb-server mariadb php-mbstring php-json
systemctl start mariadb
systemctl enable mariadb
