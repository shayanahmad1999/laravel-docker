# Use the official PHP image with Apache pre-installed
FROM php:8.3-apache

# Set the working directory for the application
WORKDIR /var/www/html

# 1. Install system dependencies (libzip-dev for the PHP zip extension)
# 2. Install necessary PHP extensions (zip for Composer, pdo_mysql for database)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix: Correct the misspelled command from 'a2enomd' to 'a2enmod'
# This is necessary for Laravel's routing (clean URLs)
RUN a2enmod rewrite

# Install Composer globally in the container
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the application source code into the container
COPY . /var/www/html/

# Set ownership to the Apache user (www-data) for the entire application folder
RUN chown -R www-data:www-data /var/www/html

# Set directory permissions for Laravel's runtime folders. 
# 775 is appropriate for the storage and cache folders.
# NOTE: The 'vendor' directory should be created/managed by composer install/update, 
# but setting ownership here is good practice if it's already copied in.
RUN chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache

# Expose the standard web port
EXPOSE 80