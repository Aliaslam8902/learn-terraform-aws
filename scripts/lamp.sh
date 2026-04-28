#!/bin/bash

# 1. Update the system packages
yum update -y

# 2. Install LAMP Stack components
# Using amazon-linux-extras for updated PHP on Amazon Linux 2 (if applicable)
# Or standard yum for RHEL/CentOS
yum install -y httpd mariadb-server php php-mysqlnd php-gd php-xml

# 3. Start and Enable Services (so they survive a reboot)
systemctl start httpd
systemctl enable httpd

systemctl start mariadb
systemctl enable mariadb

# 4. Secure Permissions for /var/www/
# Adds ec2-user to the apache group and sets directory permissions
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

# 5. Create a test PHP page to verify installation
echo "<?php phpinfo(); ?>" > /var/www/html/index.php

# 6. Basic Firewall check (if firewalld is running)
if systemctl is-active --quiet firewalld; then
    firewall-cmd --permanent --add-service=http
    firewall-cmd --reload
fi