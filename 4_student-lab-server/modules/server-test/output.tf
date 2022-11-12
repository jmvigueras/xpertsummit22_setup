output "server" {
  value = {
    id  = aws_instance.server.id
    arn = aws_instance.server.arn
    ip  = var.eni-server["ip"]
    pip = var.eni-server["pip"]
    kp  = var.key-pair_name
  }
}