##############################################################################################################
# Terraform state
##############################################################################################################
terraform {
  required_version = ">= 1.0.0"
}

##############################################################################################################
# Deployment in AWS
##############################################################################################################
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region["region"]
}
