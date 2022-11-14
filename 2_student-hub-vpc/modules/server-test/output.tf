output "server" {
  value = {
    id  = aws_instance.server.id
    arn = aws_instance.server.arn
    ip  = var.eni-server["ip"]
    pip = aws_eip.eip-server_public.public_ip
  }
}