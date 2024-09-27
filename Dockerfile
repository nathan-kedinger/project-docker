# Utilise une image PHP avec CLI
FROM php:8.2-cli

# Installe les extensions nécessaires
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    libpq-dev \
    libicu-dev \
    zlib1g-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl pdo pdo_mysql

# Installe Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installe Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash \
    && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Configure le répertoire de travail
WORKDIR /usr/src/myapp

# Copie le code source de l'application
COPY . /usr/src/myapp

# Expose le port 8000
EXPOSE 8000

# Exécute le serveur Symfony
CMD ["symfony", "server:start", "--no-tls"]
