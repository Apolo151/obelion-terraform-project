#!/bin/bash

# Update and install packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y mysql-server

# Secure MySQL setup (optional, uncomment if needed)
# sudo mysql_secure_installation

# Create database and user
sudo mysql <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'%' IDENTIFIED BY 'wppassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';

FLUSH PRIVILEGES;
EOF

# Update bind address in the MySQL configuration to 0.0.0.0
MYSQL_CONF="/etc/mysql/mysql.conf.d/mysqld.cnf"
if [ -f "$MYSQL_CONF" ]; then
    sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' "$MYSQL_CONF"
    #sudo sed -i 's/^mysqlx-bind-address.*/mysqlx-bind-address = 0.0.0.0/' "$MYSQL_CONF"
else
    echo "MySQL configuration file not found at $MYSQL_CONF"
    exit 1
fi

# Restart MySQL to apply configuration changes
sudo systemctl restart mysql
sudo systemctl enable mysql

echo "MySQL setup completed successfully."
