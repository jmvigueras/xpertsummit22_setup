##############################################################################################################
#
# FortiGate Terraform deployment
# Active Passive High Availability MultiAZ with AWS Transit Gateway with VPC standard attachment -
#
##############################################################################################################

# Access and secret keys to your environment
variable "access_key" {}
variable "secret_key" {}

# Prefix for all resources created for this deployment in AWS
# - (Not include Name as tag) -
variable "tags" {
  description = "Attribute for tag Enviroment"
  type        = map(any)
  default     = {
    Project   = "xpertsummit22"
  }
}

// Region and Availability Zone where deploy VPC and Subnets
// (recomended different region than students regions)
variable "region" {
  type = map(any)
  default = {
    "region"     = "eu-central-1"
    "region_az1" = "eu-central-1a"
  }
}

// Path prefix where users have been allocated (pattern: /path_prefix/)
variable "users_path-prefix" {
  description = "Path prefix where users have been allocated"
  type        = string
  default     = "/xpertsummit22/" 
}

// CIDR range to use for your VCP Cloud9 - Subnet will be configured with first half of the range
variable "vpc-cloud9_cidr"{
  description = "Path prefix where users have been allocated" 
  type        = string
  default     = "172.31.0.0/23"
}