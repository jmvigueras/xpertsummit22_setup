output "lab-server" {
  value = {
    id        = module.server-lab.server["id"]
    ip        = module.server-lab.server["ip"]
    pip       = module.server-lab.server["pip"]
    kp        = module.server-lab.server["kp"]
    dashboard = "http://${module.server-lab.server["pip"]}"
    phpadmin  = "http://${module.server-lab.server["pip"]}:8001"
    db_pass   = var.db["db_pass"]
    db_docker_name = var.db["db_host"]
  }
}