#!/bin/bash
sudo su
dnf install mariadb-server mariadb -y
systemctl start mariadb
systemctl enable mariadb
