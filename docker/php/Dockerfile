FROM php:8.1.13-fpm-alpine3.16

ENV TIMEZONE 'Europe/Paris'
ENV DRUSH_VERSION latest

ARG uid
ARG gid
ARG uname

RUN set -eux ; \
    \
    apk add --no-cache --virtual .build-deps \
      gettext-dev \
      icu-dev \
      libxml2-dev \
      libxslt-dev \
      libzip-dev \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev \
      libwebp-dev \
      libxpm-dev \
      imagemagick-dev ;\
    apk add --no-cache \
      gettext \
      icu-libs \
      icu-data-full \
      freetype \
      libjpeg-turbo \
      libpng \
      libwebp \
      libxpm \
      libxslt \
      libzip ; \
    docker-php-ext-configure gd \
      --with-freetype \
      --with-jpeg \
      --with-webp \
      --with-xpm ;\
    docker-php-ext-install -j "$(nproc)" \
        bcmath \
        bz2 \
        calendar \
        exif \
        gd \
        gettext \
        intl \
        opcache \
        pcntl \
        pdo_mysql ; \
    apk del .build-deps

# Git (GrumpPHP), msmtp (for emails), patch (apply patches), mysql-client.
RUN apk add --no-cache \
    sudo \
    curl \
    wget \
    bash \
    zip \
    unzip \
    git \
    msmtp \
    patch \
    mysql-client \
    openssl-dev \
    shadow

# Redis + Xdebug.
RUN apk add --update --no-cache --virtual .build-dependencies $PHPIZE_DEPS \
  && pecl install apcu redis xdebug-3.1.3 \
  && docker-php-ext-enable apcu redis xdebug \
  && pecl clear-cache \
  && apk del .build-dependencies

# Add the user to the group.
RUN groupadd -g $gid -o $uname && \
  useradd -m -u $uid -g $gid -o -s /bin/sh $uname

# Composer.
COPY --from=composer:2.4.4 /usr/bin/composer /usr/bin/composer

# Drush.
RUN curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush-launcher/releases/$DRUSH_VERSION/download/drush.phar" && \
  chmod +x /usr/local/bin/drush

WORKDIR /var/www
