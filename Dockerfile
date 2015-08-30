FROM tutum/apache-php:latest
MAINTAINER Golfen Guo <golfen.guo@daocloud.io>

ENV WORDPRESS_VER 4.3
WORKDIR /
RUN apt-get update && \
    apt-get -yq install mysql-client curl unzip wget && \
    rm -rf /app && \
    curl -0L https://cn.wordpress.org/wordpress-4.3-zh_CN.tar.gz | tar zxv && \
    mv /wordpress /app && \
    rm -rf /var/lib/apt/lists/* && \
    cd /app/wp-content/plugins && wget https://downloads.wordpress.org/plugin/hermit.zip  && unzip hermit.zip 

RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
RUN a2enmod rewrite
ADD wp-config.php /app/wp-config.php
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 80
CMD ["/run.sh"]
