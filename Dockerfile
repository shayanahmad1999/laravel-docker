FROM php:8.3-apache

WORKDIR /var/www/html

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html

RUN chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache

EXPOSE 80