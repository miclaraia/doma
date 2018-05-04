FROM php:5-apache

MAINTAINER Michael Laraia

RUN docker-php-ext-install mysql mysqli && \
    apt-get update -y && apt-get install -y libpng-dev libfreetype6-dev libjpeg62-turbo-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  && \
    docker-php-ext-install gd 

COPY src /usr/local/share/doma/
COPY ./docker/config/doma-entrypoint /usr/local/bin/
COPY ./docker/config/php.ini /usr/local/etc/php/conf.d/doma-php.ini
RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite

CMD ["doma-entrypoint"]
