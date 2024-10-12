#!/bin/bash

# Log into the remote server (step manual)
# ssh root@160.19.166.87

# Update paket sistem
sudo apt update
sudo apt upgrade -y
sudo apt install lsb-release apt-transport-https ca-certificates unzip -y

# Tambah PHP repository dan install seluruh paket sistem yang dibutuhkan
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt update
sudo apt-get install apache2 mariadb-server mariadb-client -y
sudo apt install php8.0 libapache2-mod-php8.0 php8.0-curl php8.0-intl php8.0-gd php8.0-pdo php8.0-fpm php8.0-common php8.0-mysql php8.0-xml php8.0-apcu -y

# Konfigurasi Apache modules
sudo a2dismod mpm_prefork php8.0
sudo a2enmod mpm_event rewrite proxy_fcgi setenvif php8.0
sudo a2enconf php8.0-fpm

# Secure instalasi MySQL 
sudo mysql_secure_installation <<EOF

y
y
y
y
y
EOF

# Buat database dan user Shlinkio
sudo mysql -u root -p<<MYSQL_SCRIPT
CREATE DATABASE shlinkio;
GRANT ALL ON shlinkio.* TO 'shlinkio_rw'@'localhost' IDENTIFIED BY '$hlink10!';
FLUSH PRIVILEGES;
EXIT;
MYSQL_SCRIPT

# Download dan install Shlinkio
sudo wget https://github.com/shlinkio/shlink/releases/download/v2.6.2/shlink2.6.2_php8.0_dist.zip
sudo unzip shlink2.6.2_php8.0_dist.zip -d /var/www
sudo mv /var/www/shlink* /var/www/shlinkio
sudo chown -R www-data:www-data /var/www/shlinkio
sudo -u www-data php /var/www/shlinkio/bin/install

# Download dan konfigurasi web client Shlink
sudo wget https://github.com/shlinkio/shlink-web-client/releases/download/v3.1.0/shlink-web-client_3.1.0_dist.zip
sudo unzip shlink-web-client_3.1.0_dist.zip
sudo mv ./shlink-web-client*/* /var/www/html

# Konfigurasi Apache untuk Shlinkio
sudo bash -c 'cat > /etc/apache2/sites-available/shlinkio.conf <<EOF
Alias /shlinkio "/var/www/shlinkio/public/"
<Directory /var/www/shlinkio/public>
    Options FollowSymlinks Includes ExecCGI
    AllowOverride All
    Require all granted
    Order allow,deny
    allow from all
</Directory>
EOF'

# Jalankan site Shlinkio dan restart Apache
sudo a2ensite shlinkio
sudo systemctl restart apache2

# Generate API key untuk Shlinkio
sudo -u www-data php /var/www/shlinkio/bin/cli api-key:generate
