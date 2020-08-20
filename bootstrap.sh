#!/bin/bash
sudo su
dnf install httpd php php-mysqlnd php-gd php-xml -y
dnf install php-json -y
dnf install php-mbstring -y
systemctl start httpd
systemctl enable httpd
dnf install wget -y
cd /home/ec2-user
wget https://releases.wikimedia.org/mediawiki/1.34/mediawiki-1.34.2.tar.gz
sed -i 's#/var/www/html#/var/www#g' /etc/httpd/conf/httpd.conf
sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.html.var index.php/g' /etc/httpd/conf/httpd.conf
cd /var/www
tar -zxf /home/ec2-user/mediawiki-1.34.2.tar.gz
ln -s mediawiki-1.34.2/ mediawiki
chown -R apache:apache /var/www/mediawiki
systemctl restart httpd
yum install firewalld -y
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
systemctl restart firewalld
restorecon -FR /var/www/mediawiki-1.34.2/
restorecon -FR /var/www/mediawiki
