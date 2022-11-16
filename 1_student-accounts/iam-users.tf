# Create new random string External ID for assume role
resource "random_string" "externalid_token" {
  length  = 30
  special = false
  numeric = true
}

#######################################################################################
# Create users with iam-users module
# - create user peer region
# - allocate user in path prefix
# - basic permissons granted by UserGroup
# - create role for each user to assume when deploying with Terraform
#######################################################################################

module "iam-users" {
  source = "./modules/iam-users"
  count  = length(var.regions)

  prefix           = var.prefix
  externalid_token = random_string.externalid_token.result
  tags             = var.tags
  user_number      = var.user_number-peer-region
  user_path-prefix = var.user_path-prefix
  region           = var.regions[count.index]
  group_name       = aws_iam_group.group[count.index].name
}
