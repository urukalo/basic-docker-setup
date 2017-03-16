FROM php:7.0.6-fpm

RUN apt-get update \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y zip \
    && apt-get install -y libpng-dev \
    && apt-get install -y git \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install json \
    && docker-php-ext-install gd \

     # Install the xdebug extension
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \

    && echo "" >> ~/.bashrc \
    && echo 'export PATH="/var/www/vendor/bin:$PATH"' >> ~/.bashrc \
    && echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/html/vendor/bin/phpunit'" >> ~/.bashrc

# Copy xdebug configration for remote debugging
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
