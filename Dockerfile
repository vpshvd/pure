FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /srv/app

COPY composer.json composer.lock ./

COPY . .

ENV COMPOSER_ALLOW_SUPERUSER=1

CMD composer install --no-interaction --prefer-dist --optimize-autoloader
