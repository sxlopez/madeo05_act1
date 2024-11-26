#!/bin/bash
# Copiar app.js al directorio de la AMI
sudo mkdir -p /var/www/myapp
sudo cp /tmp/app.js /var/www/myapp/

# Configurar Nginx
sudo cp /tmp/nginx_config/app.conf /etc/nginx/conf.d/

# Configurar permisos
sudo chown -R ec2-user:ec2-user /var/www/myapp

# Reiniciar servicios
sudo systemctl restart nginx
