# IMAGE BASE
FROM php:apache-bookworm

# RUN COMMANDS CONFIGURATION IMAGE DEPENDENCIES FOR GLPI

#STEP 1 UPDATE REPOSITORY
RUN apt update

# STEP 2 INSTALL DEPENDENCIES FOR PHP GD 
RUN apt-get update && apt-get install -y \
		libfreetype-dev \
		libjpeg62-turbo-dev \
		libpng-dev

# STEP 3 CONFIGURE PHP EXTENSIONS PHP GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# STEP 4 CONFIGURA PHP EXTENSIONS PHP GD
RUN docker-php-ext-install -j$(nproc) gd

# STEP 4 INSTALL INTL DEPENDENCIES
RUN apt install -y icu-devtools libicu-dev

# STEP 5 INSTALL INTL
RUN docker-php-ext-install intl

# STEP 6 CONFIGURE AND INSTALL EXIF
RUN docker-php-ext-configure exif 
RUN docker-php-ext-install exif

# STEP 7 INSTALL PACKAGE FOR LDAP DEPENDENCIES
RUN apt install -y libldap-dev

# STEP 8 CONFIGURE AND INSTALL DOCKER LDAP
RUN docker-php-ext-configure ldap 
RUN docker-php-ext-install ldap

# STEP 9 CONFIGUE DOCKER OPCACHE EXTENSION
RUN docker-php-ext-configure opcache 
RUN docker-php-ext-install opcache

# STEP 10 CONFIGUE DOCKER MYSQLI EXTENSION
RUN docker-php-ext-configure mysqli
RUN docker-php-ext-install mysqli

# STEP 11 INSTALL PACKAGE BZ2 AND ZIP
RUN apt install -y libbz2-dev libzip-dev

# STEP 11 CONFIGUE DOCKER BZ2 EXTENSION
RUN docker-php-ext-configure bz2
RUN docker-php-ext-install bz2
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip

# STEP 12 INSTALL PACKAGE FOR CONFIG APACHE
RUN apt install -y nano

# STEP 13 COPY CONFIGURATION FILE AND CREATE DIRECTORY FOR GLPI
# THIS STEPS IS RELATED ON DOCUMENTATION
# https://glpi-install.readthedocs.io/en/latest/install/index.html

# COPY BASE FILES 
COPY ./glpi /var/www/html

# COPY CONFIG AND CUSTOMIZATION FILES FOR GLPI
COPY ./files/downstream.php /var/www/html/inc

# SCRIPT FOR CREATE DIRECTORIES
COPY ./files/script.sh /tmp
RUN chmod +x /tmp/script.sh
RUN /tmp/script.sh

# ADJUST CONFIGUARTION ACCORDING GLPI MANUAL
COPY ./files/local_define.php /etc/glpi

# # CHECKING DIRETORIES
# RUN chmod 777 /tmp/log.txt
RUN cat /tmp/log.txt

# Change permission on directory
RUN chown www-data:www-data /etc/glpi -R
RUN chown www-data:www-data /var/log/glpi -R 
RUN chown www-data:www-data /var/lib/glpi -R
RUN chown www-data:www-data /var/www/html -R

# STER 13 ACTIVE MODULES IN APACHE2
RUN a2enmod rewrite
RUN a2enmod ssl

# STEP 14 COPY FILES FOR WEB SERVER
# Use the default production configuration 
COPY ./files/php.ini $PHP_INI_DIR/php.ini
# Adjustament configuration webserver for glpi
COPY ./files/000-default.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
