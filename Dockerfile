FROM php:8.3-apache

WORKDIR /var/www/html

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev \
    unzip \
    libpq-dev \
    gnupg \
    # Install Node.js/npm using NodeSource (LTS version 20 as of now)
    && curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    # Install PHP extensions
    && docker-php-ext-install zip pdo_mysql \
    # && docker-php-ext-install zip pdo pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/

# --- ADDED: Install Dependencies (PHP and JS) ---
RUN composer install --no-dev --prefer-dist --optimize-autoloader
RUN npm install && npm run build
# --------------------------------------------------

RUN chown -R www-data:www-data /var/www/html

RUN chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache

EXPOSE 80