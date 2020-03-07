FROM ubuntu
RUN apt update
RUN apt install -y python
RUN echo 1.0 >> /etc/version && apt install -y git \
 && apt install -y iputils-ping
RUN mkdir /datos
##WORKDIR DIRECTORIO DE TRABAJO##
WORKDIR /datos
RUN touch f1.txt
WORKDIR /datos1
RUN touch f2.txt

##COPY ficheros del hosts al contenedor, adminte metacaracteres##
COPY index.html .
COPY app.log /datos
##ADD copia ficheros y directorios al contenedor, admite metacaracteres ##
## con ADD permite añadir fichero .tar  ##
ADD docs docs
ADD f* /datos/
ADD f.tar .

##ENV##
ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

##ARG sirve para poner variables no tengo que poner valor ##

##ARG dir2
##RUN mkdir $dir2
##ARG user
##ENV user_docker $user
##ADD add_user.sh /datos1
##RUN /datos1/add_user.sh

##EXPOSE exponer puertos, ayuda la persona que construye el ## 
##contenedor los puertos que puede usar##
RUN apt install -y apache2
EXPOSE 80
ADD entrypoint.sh /datos1
## CMD para arrrancar servicios hay que hacerlo con un script ##
CMD /datos1/entrypoint.sh

##ENTRYPOINT##
#ENTRYPOINT ["/bin/bash"]

## VOLUME crear volumenes de forma automatica ##
## crear una página web ##

ADD paginas /var/www/html
VOLUME ["/var/www/html"]
