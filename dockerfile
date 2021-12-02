#Instalar SO CentOS 7
FROM centos:7

#Instalar Apache dentro de CentOS
RUN yum -y install httpd

#Instalar PHP dentro de CentOS
RUN yum -y install php php-cli php-common

#Instalar OpenSSL para Apache
RUN yum -y install mod_ssl openssl

#Testeo de PHP
RUN echo "<?php phpinfo(); ?>" > /var/www/html/test.php

#Copia de una pagina web de ejemplo al directorio de Apache
COPY startbootstrap-sb-admin-2/ /var/www/html/

#Copia de los certificados SSL en Apache (por defecto)
COPY ssl.conf /etc/httpd/conf.d/default.conf
COPY docker.crt /docker.crt
COPY docker.key /docker.key

#Utilización del puerto 443 para https
EXPOSE 443

#Comando para ejecucion de Apache dentro de CentOS
CMD apachectl -DFOREGROUND


 

