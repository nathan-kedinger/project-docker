# Utilise une image PHP avec CLI
FROM php:8.2-cli

# Installe les extensions nécessaires
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    libpq-dev \
    libicu-dev \
    zlib1g-dev \
    git \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl pdo pdo_mysql

# Installe Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installe Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash \
    && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Configure le répertoire de travail
WORKDIR /usr/src/myapp

# Copier tous les fichiers de l'application
COPY . .

# Installer les dépendances PHP
RUN composer install

# Expose le port 8000
EXPOSE 8000

# Exécute le serveur Symfony
CMD ["symfony", "server:start", "--no-tls", "--allow-http", "--port=8000"]
