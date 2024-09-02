FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libxml2-dev \
    libxslt1-dev \
    libpq-dev \
    curl \
    zip \
    && docker-php-ext-install zip xml xsl soap pdo_pgsql pgsql mbstring bcmath intl opcache sockets \
    && docker-php-ext-enable opcache \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY composer.json composer.lock ./

RUN composer install --no-dev --optimize-autoloader --ignore-platform-req=ext-opcache

COPY . .

EXPOSE 9000