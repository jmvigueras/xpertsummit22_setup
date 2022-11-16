output "hub_fgt" {
  value = module.fgt-vpc-hub.fgt
}

output "site_fgt" {
  value = module.fgt-spoke-site.fgt
}

output "site_eni-server" {
  value = module.fgt-spoke-site.eni-server
}

output "hub_eni-server" {
  value = module.fgt-vpc-hub.eni-server
}
