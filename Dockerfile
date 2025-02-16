# Use an official PHP with Apache image
FROM php:8.2-apache

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zip unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql \
    && a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy application files (if any)
COPY . /var/www/html/

# Expose Apache port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
