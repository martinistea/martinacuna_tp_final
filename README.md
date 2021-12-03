# TP Final Infraestructura de Servidores

- ## Explicación de dockerfile

  El dockerfile creado contiende las siguientes lineas:

  ```bash
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
  
  ```

- ## Explicación de los ficheros de configuración:

  Los siguientes archivos son necesarios para la configuración:

  - dockerfile: contiene la información para la contrucción de la imagen
  - docker.crt: contiene el certificado para conexión SSL
  - docker.key: contiene la llave para conexión SSL
  - ssl.conf: contiene la configuración para la utilización de SSL en Apache
  - startbootstrap-sb-admin-2: contiene una página web de ejemplo



- ## Explicación de pasos para la contrucción de la imagen

  Para la contrucción de la imagen se debe ejecutar el siguiente comando:

  ```bash
  docker build -t centos:apache_ssl-php .
  ```

  - NOTA:

  El comado debe ser ejecutado en el mismo directorio donde se encuentra el dockerfile

- ## Pasos para el deploy del contenedor

  Para el deploy del contenedor, se sebe ejecutar el siguiente comando:

  ```bash
  docker run -d --name apache_ssl-php -v /opt/apache_log/:/var/log/httpd -p 443:443 centos:apache_ssl-php
  ```

  La opción -v crea el volumen en el directorio /opt/apache_log para alojar los logs de apache ubicados en /var/log/httpd

  Los puertos 443 son utilizados para la comunicación SSL
