// create test servers spoke test Site
module "server-lab" {
  //source = "github.com/jmvigueras/modules//aws/fgt-1az-vpc-sec"
  source = "./modules/server-test"

  tags = {
    Name    = "server-app-01"
    Project = "xs22"
  }

  eni-server       = data.terraform_remote_state.student-hub-vpc.outputs.hub_eni-server
  key-pair_name    = var.key-pair_name != null ? var.key-pair_name : aws_key_pair.server-kp[0].key_name
  git_uri          = var.git_uri
  git_uri_app-path = var.git_uri_app-path
  lab_fqdn         = var.lab_fqdn
  externalid-token = data.terraform_remote_state.student-accounts.outputs.externalid-token
  random-url-db    = random_string.random-url-db.result
  db               = var.db
  instance_type    = var.instance_type
}

// Create key-pair if not provided
resource "aws_key_pair" "server-kp" {
  count      = var.key-pair_name != null ? 0 : 1
  key_name   = "${var.tags["Name"]}-server-kp-${random_string.random_str.result}"
  public_key = var.key-pair_rsa-public-key
}

// Create random string for api_key name
resource "random_string" "random-url-db" {
  length  = 10
  special = false
  numeric = false
}

// Create random string for api_key name
resource "random_string" "random_str" {
  length  = 5
  special = false
  numeric = false
}

// Import data from deployment 2_student-hub-vpc
data "terraform_remote_state" "student-hub-vpc" {
  backend = "local"
  config = {
    path = "../2_student-hub-vpc/terraform.tfstate"
  }
}

// Import data from deployment 1_student-accounts
data "terraform_remote_state" "student-accounts" {
  backend = "local"
  config = {
    path = "../1_student-accounts/terraform.tfstate"
  }
}