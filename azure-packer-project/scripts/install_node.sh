#!/bin/bash
# Liberar bloqueos de yum
sudo rm -f /var/run/yum.pid
sudo yum clean all

# Actualizar sistema
sudo yum update -y
sleep 30

# Habilitar Node.js
sudo amazon-linux-extras enable nodejs
sudo yum install -y nodejs
sleep 30
