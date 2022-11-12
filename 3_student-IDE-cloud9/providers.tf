##############################################################################################################
# Deployment in AWS
##############################################################################################################
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region["region"]
}

##############################################################################################################
# Configure provider alias to operate in different regions
##############################################################################################################
/*
provider "aws" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = "eu-west-1"
  alias       = "main"
}
    
provider "aws" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = "eu-west-2"
  alias       = "eu-west-2"
}

provider "aws" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = "eu-west-3"
  alias       = "eu-west-3"
}

provider "aws" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = "eu-north-1"
  alias       = "eu-north-1"
}

provider "aws" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = "eu-central-1"
  alias       = "eu-central-1"
}

terraform {
    required_providers {
    aws = {
          source  = "hashicorp/aws"
          version = ">= 4.0.0"
        }
    }
}
*/
