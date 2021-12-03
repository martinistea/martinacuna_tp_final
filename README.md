# martinacuna_tp_final
TP Final Infraestructura de servidores

--Explicacion dockerfile
	El archivo dockerfile generado para la construcción de la imagen contiene las siguientes entradas:
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

-- Contrucción de la imagen
	El comando para la contrucción de la imagen en Docker es:

docker build -t centos:apache_ssl-php .

	El mismo debe ser ejecutado en el mismo directorio donde se encuentra el archivo dockerfile

-- Deploy del contenedor
	Para el deploy del contenedor, se debe ejecutar el siguiente comando:

docker run -d --name apache_ssl-php -v /opt/apache_log/:/var/log/httpd -p 443:443 centos:apache_ssl-php

	-v indica la utilización de un volumen, donde se alojan de manera persistente los logs de apache para el análisis de los 
	mismos en caso de ser necesario

