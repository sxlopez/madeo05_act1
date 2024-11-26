azure-packer-project/
├── app.js                # Tu aplicación Node.js
├── nginx_config          # Configuración personalizada de Nginx
│   └── app.conf
├── scripts/              # Scripts para instalación
│   ├── install_node.sh
│   ├── install_nginx.sh
│   └── configure_app.sh
├── template.pkr.hcl      # Archivo de configuración de Packer para Azure
