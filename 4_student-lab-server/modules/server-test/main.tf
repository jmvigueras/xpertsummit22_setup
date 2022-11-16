##############################################################################################################
# VM LINUX server
##############################################################################################################

// Server
resource "aws_instance" "server" {
  ami           = data.aws_ami.server_ami-amazon.id
  instance_type = var.instance_type
  key_name      = var.key-pair_name
  user_data     = data.template_file.data-server_user-data.rendered
  network_interface {
    device_index         = 0
    network_interface_id = var.eni-server["id"]
  }

  tags = var.tags
}

// Retrieve AMI info
data "aws_ami" "server_ami-ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "server_ami-amazon" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

// Create user-data for server
data "template_file" "data-server_user-data" {
  template = file("${path.module}/templates/server_user-data.tpl")
  vars = {
    git_uri          = var.git_uri
    git_uri_app-path = var.git_uri_app-path
    docker_file      = data.template_file.data-server_user-data_dockerfile.rendered
    nginx_config     = data.template_file.data-server_user-data_nginx_config.rendered
    nginx_html       = data.template_file.data-server_user-data_nginx_html.rendered

    db_host  = var.db["db_host"]
    db_user  = var.db["db_user"]
    db_pass  = var.db["db_pass"]
    db_name  = var.db["db_name"]
    db_table = var.db["db_table"]
    db_port  = var.db["db_port"]
  }
}

// Create dockerfile
data "template_file" "data-server_user-data_dockerfile" {
  template = file("${path.module}/templates/docker-compose.yaml")
  vars = {
    lab_fqdn      = var.lab_fqdn
    random-url-db = var.random-url-db
    db_host       = var.db["db_host"]
    db_user       = var.db["db_user"]
    db_pass       = var.db["db_pass"]
    db_name       = var.db["db_name"]
    db_table      = var.db["db_table"]
    db_port       = var.db["db_port"]
  }
}

// Create nginx config
data "template_file" "data-server_user-data_nginx_config" {
  template = file("${path.module}/templates/nginx_config.tpl")
  vars = {
    externalid-token = var.externalid-token
    random-url-db    = var.random-url-db
  }
}

// Create nginx html
data "template_file" "data-server_user-data_nginx_html" {
  template = file("${path.module}/templates/nginx_html.tpl")
  vars = {
    lab_fqdn = var.lab_fqdn
  }
}