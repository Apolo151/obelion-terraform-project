#!/bin/bash

# download wordpress
cd /var/www/

rm -rf /var/www/wordpress

sudo wget http://wordpress.org/latest.tar.gz

sudo tar -xzvf latest.tar.gz

sudo chown -R www-data:www-data /var/www/wordpress

sudo chmod -R 755 /var/www/wordpress

# create wp-config.php

sudo cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
sudo sed -i 's/database_name_here/${wordpress_database_name}/' /var/www/wordpress/wp-config.php
sudo sed -i 's/username_here/${wordpress_database_user}/' /var/www/wordpress/wp-config.php
sudo sed -i 's/password_here/${wordpress_database_password}/' /var/www/wordpress/wp-config.php
sudo sed -i 's/localhost/${database_private_ip}/' /var/www/wordpress/wp-config.php