#!/bin/bash
# Source the Cloudcenter user env file to onboard C3 specifc vars
echo "Running PostConfig.sh" >> /var/log/nextcloud_installer.log

echo "Restart Apache" >> /var/log/nextcloud_installer.log
sudo service httpd restart


source /usr/local/cliqr/etc/userenv

# Referencing DB credentials and target IPs
export NEXTCLOUD_DB_USER=nextcloud
export NEXTCLOUD_DB_PASS=nextpassword
export NEXTCLOUD_DB_NAME=cloud
export NEXTCLOUD_DB_HOST=$CliqrTier_MySQL_PUBLIC_IP

# Run first time configuration 
cd /var/www/nextcloud
sudo -u apache php occ  maintenance:install --database "mysql" --database-name $NEXTCLOUD_DB_NAME  --database-user $NEXTCLOUD_DB_USER --database-pass $NEXTCLOUD_DB_PASS --admin-user $NEXTCLOUD_ADMIN_USER --admin-pass $NEXTCLOUD_ADMIN_PASS --database-host $NEXTCLOUD_DB_HOST --data-dir "/var/nextcloud_data" >> /var/log/nextcloud_installer.log


source /usr/local/cliqr/etc/userenv
export NEXTCLOUD_DB_HOST $CliqrTier_MySQL_PUBLIC_IP

# Wait before accessing config.php as it won't be immediately ready after first configuration 
sleep 5

sudo cp /var/www/nextcloud/config/config.php /var/www/nextcloud/config/config.php.bck
sudo sed -i s/localhost/$CliqrTier_WEB_PUBLIC_IP/g /var/www/nextcloud/config/config.php


