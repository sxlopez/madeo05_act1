packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  default = "us-west-2"
}

variable "ami_name" {
  default = "node-nginx-hello-world"
}

source "amazon-ebs" "amazon-linux" {
  region        = var.aws_region
  instance_type = "t2.micro"
  ami_name      = var.ami_name
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.amazon-linux"]

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
