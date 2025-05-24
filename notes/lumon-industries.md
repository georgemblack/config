# Lumon Industries (Raspberry Pi)

The following is documentation for the [Lumon Industries](https://severance.wiki/lumon_industries) server (Raspberry Pi) running in my closet. (If you're a potential employer reading this – it's a joke from a TV show.)

## Connecting

Lumon Industries systems are only available on the home network. To connect:

```
ssh georgeblack@lumonindustries.local
```

A local alias can connect quickly:

```
lumon
```

The appropriate SSH key is stored in 1Password.

## Configuring & Updating

To modify Raspberry Pi settings, use the built in config tool:

```
sudo raspi-config
```

To update software dependencies:

```
sudo apt update
sudo apt upgrade
sudo apt full-upgrade
```

# Kirby Setup

## Installation Steps

Install Apache, PHP, and other dependencies:

```
sudo apt install vim software-properties-common
curl -sSL https://packages.sury.org/php/README.txt | sudo bash -x
sudo apt install apache2 php8.3 php8.3-mbstring php8.3-curl php8.3-xml libapache2-mod-php8.3 zip unzip
```

Add Apache configuration for Kirby:

```
cat <<EOF > "/etc/apache2/sites-available/kirby.conf"
<VirtualHost *:443>
        ServerName kirby.george.black
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        SSLEngine on
        SSLCertificateFile /etc/ssl/certs/cloudflare.crt
        SSLCertificateKeyFile /etc/ssl/private/cloudflare.key
        <Directory /var/www/html/>
                Options FollowSymlinks
                AllowOverride All
                Require all granted
        </Directory>
</VirtualHost>
EOF
```

Start Apache webserver:

```
systemctl enable apache2
systemctl start apache2
```

Make other Apache configuration changes, and restart:

```
rm /var/www/html/index.html # Remove default index.html
a2enmod rewrite             # Enable mod_rewrite
a2enmod ssl                 # Enable mod_ssl
a2dissite 000-default.conf  # Disable default site
sudo a2ensite kirby.conf    # Enable Kirby site
systemctl reload apache2
```

Write Cloudflare origin certificates:

```
sudo vim /etc/ssl/certs/cloudflare.crt
sudo vim /etc/ssl/private/cloudflare.key
chown www-data:www-data /etc/ssl/certs/cloudflare.crt /etc/ssl/private/cloudflare.key
```

Create a Cloudflare tunnel via the Cloudflare dashboard, with the following settings:

* Hostname: `kirby.george.black`
* Service: `https://localhost:443`
* Origin Server Name: `kirby.george.black`

## Site Data

To copy site data to/from the Raspberry Pi, use Cyberduck & SFTP. (Note the Mac App Store version will not work – it won't work with the SSH key stored in 1Password.)

https://docs.cyberduck.io/tutorials/sftp_publickeyauth_1password/

Modify the permissions of `/var/www/html` to ensure the `georgeblack` user has permission to read and write:

```
sudo usermod -aG www-data georgeblack
```

Move data to/from this directory as needed.

## Misc

When modifying files in `/var/www/html`, i.e. upgrading Kirby, be sure to set `www-data` as the owning group/user:

```
sudo chown -R www-data:www-data /var/www/html
```
