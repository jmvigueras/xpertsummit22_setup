
output "iam-user_console-password" {
  sensitive = true
  value     = module.iam-users.*.iam-user_console-password
}

output "iam-user_access-key" {
  sensitive = true
  value     = module.iam-users.*.iam-user_access-key
}

output "iam-user_arn" {
  sensitive = true
  value     = module.iam-users.*.iam-user_arn
}

output "externalid-token" {
  sensitive = true
  value     = random_string.externalid_token.result
}

output "user_path-prefix" {
  sensitive = true
  value     = var.user_path-prefix
}

