<h1 align="center"><img src="https://raw.githubusercontent.com/shlinkio/shlink.io/main/public/images/shlink-hero.png"></h1>

[Sekilas Tentang](#sekilas-tentang) | [Instalasi](#instalasi) | [Konfigurasi](#konfigurasi) | [Otomatisasi](#otomatisasi) | [Cara Pemakaian](#cara-pemakaian) | [Pembahasan](#pembahasan) | [Referensi](#referensi)
:---:|:---:|:---:|:---:|:---:|:---:|:---:



# Sekilas Tentang
[`^ kembali ke atas ^`](#)

isi deskripsi

# Instalasi
[`^ kembali ke atas ^`](#)

#### Kebutuhan Sistem :
- Unix, Linux atau Windows.
- Apache Web server.
- PHP 8.2.
- MariaDB
- VPS 

#### Proses Instalasi :
1. Login kedalam server menggunakan SSH. Untuk pengguna windows bisa menggunakan Virtual Machine berbasis Linux
    ```
    $ ssh root@160.19.166.87
    ```

2. Pastikan seluruh paket sistem kita *up-to-date*, dan install seluruh kebutuhan sisrem seperti `Apache`, `PHP`, `MySQL` dan `MariaDB`.
    ```
    $ sudo apt update
    $ sudo apt upgrade -y
    $ sudo apt install lsb-release apt-transport-https ca-certificates unzip -y
    $ sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
    $ echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
    $ sudo apt update
    $ sudo apt-get install apache2 mariadb-server mariadb-client -y
    $ sudo apt install php8.0 libapache2-mod-php8.0 php8.0-curl php8.0-intl php8.0-gd php8.0-pdo php8.0-fpm php8.0-common php8.0-mysql php8.0-xml php8.0-apcu -y
    $ sudo a2dismod mpm_prefork php8.0
    $ sudo a2enmod mpm_event rewrite proxy_fcgi setenvif php8.0
    $ sudo a2enconf php8.0-fpm
    $ sudo su
    $ mysql_secure_installation
    ```
2. Buat database untuk **Shlinkio**
    ```
    $ mysql -u root -p
    $ CREATE DATABASE shlinkio;
    $ GRANT ALL ON shlinkio.* to 'shlinkio_rw'@'localhost' IDENTIFIED BY '$hlink10!';
    $ FLUSH PRIVILEGES;
    $ EXIT;
    $ exit
    ```

3. Unduh **Shlinkio** ke dalam direktori kita. 
    ```
    $ sudo wget https://github.com/shlinkio/shlink/releases/download/v2.6.2/shlink2.6.2_php8.0_dist.zip
    ```

4. Ekstrak file yang telah diunduh ke dalam direktori yang kita inginkan.
    ```
    $ sudo unzip shlink2.6.2_php8.0_dist.zip -d /var/www
    $ sudo mv /var/www/shlink* /var/www/shlinkio
    ```

5. Ubah otorisasi kepemilikan ke user www-data (webserver)
    ```
    $ sudo chown -R www-data:www-data /var/www/shlinkio
    ```

6. Jalankan installer shlinkioo
    ```
    $ sudo -u www-data php /var/www/shlinkio/bin/install
    ```

7. Konfigurasi Apache web server.
    ```
    $ sudo wget https://github.com/shlinkio/shlink-web-client/releases/download/v3.1.0/shlink-web-client_3.1.0_dist.zip
    $ sudo unzip shlink-web-client_3.1.0_dist.zip
    $ sudo mv ./shlink-web-client*/* /var/www/html
    $ sudo nano /etc/apache2/sites-available/shlinkio.conf

    Alias /shlinkio "/var/www/shlinkio/public/"
    <Directory /var/www/shlinkio/public>
    Options FollowSymlinks Includes ExecCGI
    AllowOverride All
    Require all granted
    Order allow,deny
    allow from all
    </Directory>
    ```
8. Jalankan site shlinkio
   ```
   $ sudo a2ensite shlinkio
   ```
9. Restart kembali Apache web server.
    ```
    $ sudo systemctl restart apache2
    ```
10. Generate API key
    ```
    $ sudo -u www-data php /var/www/shlinkio/bin/cli api-key:generate
    ```

11. Kunjungi alamat IP web server
    - Kunjungi alamat domain

      ![1](Screenshots/shlinkio1.png )

    - Pilih add your first server

      ![2](Screenshots/shlinkio2.png )

    - Isi name sesuai keinginan

    - Isi URL dengan http://(alamat IP)/shlinkio

    - Isi API Key dengan API yang didapat dari generate API key

      ![3](Screenshots/shlinkio1.png )


12. Proses instalasi selesai



# Konfigurasi
[`^ kembali ke atas ^`](#)


# Maintenance
[`^ kembali ke atas ^`](#)


# Otomatisasi
[`^ kembali ke atas ^`](#)


# Cara Pemakaian
[`^ kembali ke atas ^`](#)

isi cara pemakaian


# Pembahasan
[`^ kembali ke atas ^`](#)

isi pembahasan

# Referensi
[`^ kembali ke atas ^`](#)

1. [Self-hosted URL Shortener with Shlink](https://i12bretro.github.io/tutorials/0225.html) - Github
3.
