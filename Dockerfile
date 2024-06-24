#
# PHP_VERSION 7.3
#
#FROM debian:stretch-slim
FROM debian:11-slim
RUN echo "Europe/Paris" > /etc/timezone

# Node version
ENV NODE_VERSION 14

# PHP version
ENV PHP_VERSION 7.3

# dependencies required for running "phpize"
# (see persistent deps below)
ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev \
		file \
		g++ \
		gcc \
    libc-dev \
		make \
		pkg-config \
		re2c
  
RUN apt-get update && apt-get install -y \
    $PHPIZE_DEPS \
    ca-certificates \
    curl \
    xz-utils \
    sudo \
    git \
    vim \
    nano \
    unzip \
    python \
    apt-transport-https \
    lsb-release \
    cron \
    wget 

RUN echo "deb http://deb.debian.org/debian testing main" | tee -a /etc/apt/sources.list
RUN wget -O- https://packages.sury.org/php/apt.gpg | apt-key add - && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
  apache2 \
  php$PHP_VERSION \
  libapache2-mod-php$PHP_VERSION \
  php$PHP_VERSION-mysql \
  php$PHP_VERSION-curl \
  php$PHP_VERSION-opcache \
  php$PHP_VERSION-cli \
  php$PHP_VERSION-intl \
  php$PHP_VERSION-json \
  php$PHP_VERSION-common \
  #php$PHP_VERSION-apcu-bc \
  php$PHP_VERSION-memcached \
  php$PHP_VERSION-xml \
  php$PHP_VERSION-zip \
  php$PHP_VERSION-soap \
  php$PHP_VERSION-mbstring \
  php$PHP_VERSION-redis \
  php$PHP_VERSION-sqlite3
  
RUN apt-get install -y php$PHP_VERSION-apcu --no-install-recommends && apt-get install -y php$PHP_VERSION-apcu-bc --no-install-recommends

# install composer
RUN mkdir -p /tmp/composer_version && \
    cd /tmp/composer_version && \
    curl "https://getcomposer.org/download/1.10.10/composer.phar" -o "composer.phar" && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    rm -rf /tmp/composer_version


#Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends yarn


# Install aws-cli
RUN mkdir -p /tmp/aws && \
    cd /tmp/aws && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install && \
    rm -rf /tmp/aws

# Creating the user and group
RUN groupadd user && useradd -g user -m -d /home/user user -s /bin/bash

#clean apt lib
RUN rm -r /var/lib/apt/lists/*


