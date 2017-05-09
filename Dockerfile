FROM php:7.1-fpm-alpine
MAINTAINER bytepark GmbH <code@bytepark.de>


RUN apk upgrade -U && \
    apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/main add \
    libressl2.5-libcrypto libressl2.5-libssl musl curl bash

# Add PHP 7
RUN apk upgrade -U && \
    apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/community add \
    shadow \
    php7-ctype \
    php7-mcrypt \
    php7-curl \
    php7-fileinfo \
    php7-json \
    php7-ldap \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqli \
    php7-opcache \
    php7-openssl \
    php7-pdo_mysql \
    php7-phar \
    php7-simplexml \
    php7-tokenizer \
    php7-xml \
    php7-xmlwriter \
    php7-xsl \
    php7-zlib

COPY /rootfs /

RUN mkdir -p /var/log/php-fpm && \
    touch /var/log/php-fpm/fpm-error.log

# cleanup
RUN rm -fr /var/cache/apk/*

EXPOSE 9000

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD [ "/usr/local/sbin/php-fpm", "-F" ]