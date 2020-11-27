FROM php:7.2-fpm

RUN apt-get update && buildDeps="libpq-dev libzip-dev" && apt-get install -y $buildDeps git nano wget --no-install-recommends
RUN docker-php-ext-install pdo pdo_pgsql pdo_mysql pgsql zip bcmath

RUN wget https://getcomposer.org/composer.phar && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer

RUN pecl install -o -f redis && \
    pecl install xdebug-2.9.5 && \
    docker-php-ext-enable redis xdebug && \
    rm -rf /tmp/pear

RUN rm /etc/apt/preferences.d/no-debian-php \
    && apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        jpegoptim \
        optipng \
        libxml2-dev \
        php-soap \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd soap

# intl extension
RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN apt-get install -y procps

RUN apt-get install -y curl
RUN apt-get update
RUN apt-get install -y openssh-server

COPY php-custom.ini /usr/local/etc/php/conf.d/php-custom.ini

RUN composer self-update

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

ADD .bashrc /root/
ADD .bashrc /var/www/

RUN mkdir /var/www/.ssh
RUN chown -R www-data:www-data /var/www

USER www-data

WORKDIR /app
