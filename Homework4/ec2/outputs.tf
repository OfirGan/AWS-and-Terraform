output "db_servers_private_ips" {
  value = module.ec2.db_servers_private_ips
}

output "web_servers_public_ips" {
  value = module.ec2.web_servers_public_ips
}

output "alb_public_dns" {
  value = module.ec2.alb_public_dns
}
