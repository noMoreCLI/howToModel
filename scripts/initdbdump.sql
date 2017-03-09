CREATE DATABASE IF NOT EXISTS cloud;
CREATE USER 'nextcloud'@'%' IDENTIFIED BY 'nextpassword';
GRANT ALL PRIVILEGES ON cloud.* TO 'nextcloud'@'%';

