FROM php:8.2-fpm

# Installa dipendenze di sistema necessarie per PostgreSQL e altre estensioni PHP
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

# Installa APCu per Prometheus
RUN pecl install apcu && docker-php-ext-enable apcu

WORKDIR /var/www/html

# Installa Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia il codice sorgente
COPY . .

# Installa le dipendenze PHP
RUN composer install --no-dev --optimize-autoloader

# Imposta permessi per i log
RUN mkdir -p /var/log/php_app && chown -R www-data:www-data /var/log/php_app