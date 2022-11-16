output "lab-server" {
  value = {
    id             = module.server-lab.server["id"]
    ip             = module.server-lab.server["ip"]
    pip            = module.server-lab.server["pip"]
    kp             = module.server-lab.server["kp"]
    portal_uri     = "http://${module.server-lab.server["pip"]}"
    lab_uri        = "http://${module.server-lab.server["pip"]}/${data.terraform_remote_state.student-accounts.outputs.externalid-token}"
    phpadmin       = "http://${module.server-lab.server["pip"]}/${random_string.random-url-db.result}"
    db_pass        = var.db["db_pass"]
    db_docker_name = var.db["db_host"]
  }
}