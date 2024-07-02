#
# PHP_VERSION 5.6
#
#FROM debian:stretch-slim
FROM debian:10.1-slim




RUN echo "Europe/Paris" > /etc/timezone


# Node version
ENV NODE_VERSION 8

# PHP version
ENV PHP_VERSION 5.6

# dependencies required for running "phpize"
# (see persistent deps below)
ENV PHPIZE_DEPS \
                gnupg2  \
		autoconf \
		dpkg-dev \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkg-config \
		re2c

RUN apt-get update; apt-get install -y libgnutls30
RUN apt-get update
RUN apt-get update && apt-get install -y \

    $PHPIZE_DEPS \
    apt-utils \
    acl \
    libz-dev \
    bzip2 \
    libssl-dev \
    libpng-dev \
    graphicsmagick \
    libjpeg-progs \
    pngquant \
    build-essential \
    ca-certificates \
    curl \
    xz-utils \
    sudo \
    git \
    vim \
    unzip \
    python \
    apt-transport-https \
    lsb-release \
    cron \
    curl \
    wget \
#	stunnel4 \
    nginx

# Add the Sury repository for PHP 7.3
#RUN apt-key adv --fetch-keys 'https://packages.sury.org/php/apt.gpg' > /dev/null 2>&1 && \
#    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
#RUN wget -qO /tmp/apt.gpg https://packages.sury.org/php/apt.gpg && \
#    apt-key add /tmp/apt.gpg

sudo echo "deb http://packages.dotdeb.org $(lsb_release -cs) all" | sudo tee -a /etc/apt/sources.list.d/dotdeb.list
sudo wget -qO- https://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -

# Add the Sury repository for PHP 5.6
RUN echo "deb https://packages.sury.org/php/ buster main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
   \
  php$PHP_VERSION \
  php$PHP_VERSION-fpm \
  php$PHP_VERSION-mysql \
  php$PHP_VERSION-gd \
  php$PHP_VERSION-imagick \
  php$PHP_VERSION-dev \
  php$PHP_VERSION-curl \
  php$PHP_VERSION-opcache \
  php$PHP_VERSION-cli \
  php$PHP_VERSION-intl \
  php$PHP_VERSION-tidy \
  php$PHP_VERSION-imap \
  php$PHP_VERSION-json \
  php$PHP_VERSION-pspell \
  php$PHP_VERSION-recode \
  php$PHP_VERSION-common \
  php$PHP_VERSION-sybase \
  php$PHP_VERSION-sqlite3 \
  php$PHP_VERSION-bz2 \
  php$PHP_VERSION-common \
  php$PHP_VERSION-memcached \
  php$PHP_VERSION-redis \
  php$PHP_VERSION-xml \
  php$PHP_VERSION-shmop \
  php$PHP_VERSION-mbstring \
  php$PHP_VERSION-zip \
  php$PHP_VERSION-soap \
  php$PHP_VERSION-bcmath && \
  apt-get install -y php$PHP_VERSION-apcu --no-install-recommends

# composer install
RUN curl -sS https://getcomposer.org/installer | php
RUN sudo mv composer.phar /usr/local/bin/composer
RUN sudo chmod +x /usr/local/bin/composer
