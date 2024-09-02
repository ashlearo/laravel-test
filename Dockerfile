FROM php:8.2-fpm

# Установка необходимых расширений PHP
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libxml2-dev \
    libxslt1-dev \
    libpq-dev \
    libicu-dev \
    libbz2-dev \
    libssl-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libmcrypt-dev \
    libpng-dev \
    zlib1g-dev \
    libevent-dev \
    libcurl4-openssl-dev \
    curl \
    unzip

# Установка PHP расширений
RUN docker-php-ext-install zip xml xsl soap pdo_pgsql pgsql mbstring bcmath intl sockets

RUN docker-php-ext-install opcache && docker-php-ext-enable opcache

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Копируем файлы composer.json и composer.lock
COPY composer.json /var/www/
# COPY composer.json composer.lock /var/www/

# Установка зависимостей Laravel
RUN composer install --no-dev --optimize-autoloader
# RUN composer install --no-dev --optimize-autoloader --ignore-platform-req=ext-opcache


# Установка Supervisor
RUN apt-get install -y supervisor

