variable "azure_subscription_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "image_name" {
  default = "node-nginx-hello-world"
}
variable "resource_group_name" {
  default = "packer-resource-group"
}
variable "location" {
  default = "eastus"
}

source "azure-arm" "ubuntu_image" {
  subscription_id       = var.azure_subscription_id
  client_id             = var.azure_client_id
  client_secret         = var.azure_client_secret
  tenant_id             = var.azure_tenant_id

  managed_image_name    = var.image_name
  managed_image_resource_group_name = var.resource_group_name

  location              = var.location
  vm_size               = "Standard_B1s"
  os_type               = "Linux"

  image_publisher       = "Canonical"
  image_offer           = "UbuntuServer"
  image_sku             = "22.04-LTS"
  azure_tags = {
    environment = "Development"
  }
}

build {
  sources = ["source.azure-arm.ubuntu_image"]

  provisioner "file" {
    source      = "app.js"
    destination = "/tmp/app.js"
  }

  provisioner "file" {
    source      = "nginx_config"
    destination = "/tmp/nginx_config"
  }

  provisioner "shell" {
    scripts = [
      "scripts/install_node.sh",
      "scripts/install_nginx.sh",
      "scripts/configure_app.sh"
    ]
  }
}
