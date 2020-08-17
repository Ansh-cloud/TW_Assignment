#!/bin/bash
sudo su
dnf install httpd php php-mysqlnd php-gd php-xml
cd /home/ec2-user
wget https://releases.wikimedia.org/mediawiki/1.34/mediawiki-1.34.2.tar.gz
cd /var/www/html
tar -zxf /home/ec2-user/mediawiki-1.34.2.tar.gz
ln -s mediawiki-1.34.2/ mediawiki
chown -R apache:apache /var/www/mediawiki
systemctl start httpd
systemctl enable httpd
sed -i 's/DirectoryIndex index.html/DirectoryIndex index.html index.html.var index.php/g' /etc/httpd/conf/httpd.conf
systemctl restart httpd
dnf install firewalld
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
systemctl restart firewalld
restorecon -FR /var/www/mediawiki-1.34.2/
restorecon -FR /var/www/mediawiki