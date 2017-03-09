#!/bin/bash

# Source the Cloudcenter user env file to onboard C3 specifc vars
source /usr/local/cliqr/etc/userenv

echo "Remove old PHP packages" > /var/log/nextcloud_installer.log
# Remove old PHP packages
yum remove php.x86_64 php-cli.x86_64 php-common.x86_64 php-gd.x86_64 php-ldap.x86_64 php-mbstring.x86_64 php-mcrypt.x86_64 php-mysql.x86_64 php-pdo.x86_64 -y >> /var/log/owncloud_installer.log

echo "configure new Repo" >> /var/log/nextcloud_installer.log
# Configuring new repo for PHP55
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm

echo "Install PHP 5.6 and packages" >> /var/log/nextcloud_installer.log
# Installing new PHP packages for owncloud
yum install -y php56w php56w-mysql php56w-xml php56w-gd >> /var/log/nextcloud_installer.log
yum install -y php56w-mbstring >> /var/log/nextcloud_installer.log
yum install -y php56w-posix >> /var/log/nextcloud_installer.log

echo "Creating Directories" >> /var/log/nextcloud_installer.log
# Creating ownCloud data directory, assign ownership and permissions 
mkdir -p /var/nextcloud_data 
chown -R apache:apache /var/nextcloud_data/
chmod -R 755 /var/nextcloud_data

echo "Add http to https redirect" >> /var/log/nextcloud_installer.log
# Create a new VirtualHost in the default virtual host configuration file and enable HTTPS redirection
echo -e "<VirtualHost *:80>\n    Redirect permanent / https://$CliqrTier_WEB_PUBLIC_IP/nextcloud\n</VirtualHost>" >> /etc/httpd/sites-enabled/default-ssl

