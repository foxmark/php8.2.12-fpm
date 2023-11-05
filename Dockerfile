FROM php:8.2.12-fpm

RUN apt-get update && apt-get install -y --no-install-recommends libxslt-dev zlib1g-dev g++ git libicu-dev zip libzip-dev zip \
    && docker-php-ext-install intl opcache pdo pdo_mysql xsl bcmath \
    && pecl install redis \
    && pecl install apcu \
    && pecl install xdebug \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

WORKDIR /app/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --version=2.6.5 --filename=composer
RUN curl --fail --location "https://github.com/symfony-cli/symfony-cli/releases/download/v5.6.2/symfony-cli_linux_amd64.tar.gz" > "/tmp/symfony_cli.tar.gz"
RUN tar -xz --directory "/tmp" -f "/tmp/symfony_cli.tar.gz"
RUN rm "/tmp/symfony_cli.tar.gz"
RUN mv "/tmp/symfony" "/usr/local/bin/symfony"