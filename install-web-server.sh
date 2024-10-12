#!/bin/bash

# Atualiza pacotes do servidor
apt update && apt upgrade -y

# Instalar apache e unzip
apt install apache2 -y && apt install unzip -y

# Download da aplicação no github
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

# Descompactar a aplicação na pasta de destino
unzip main.zip -d /var/www/html/
cd /var/www/html/linux-site-dio-main
mv * .. && mv ./.[!.]* .. && cd ..
rmdir linux-site-dio-main

# Habilitando e reiniciando serviço apache
systemctl enable apache2
systemctl restart apache2

