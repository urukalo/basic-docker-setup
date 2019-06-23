FROM php:7.3-fpm

RUN apt-get update && apt-get install -y \
    git \
    zip \
    libmemcached-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libpq-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pcntl bcmath pdo_pgsql soap mbstring zip pgsql exif

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

     # Install the xdebug extension
#    && pecl install xdebug \
#    && docker-php-ext-enable xdebug \
#    && echo "" >> ~/.bashrc \
#    && echo 'export PATH="/var/www/vendor/bin:$PATH"' >> ~/.bashrc \
#    && echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/html/vendor/bin/phpunit'" >> ~/.bashrc

# Copy xdebug configration for remote debugging
#COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
