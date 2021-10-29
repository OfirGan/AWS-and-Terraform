# ##################################################################################
# # OUTPUT
# ##################################################################################

output "nginx_web_srv_1a_public_ip" {
  value = aws_instance.nginx_web_srv_1a.public_ip
}

output "nginx_web_srv_1b_public_ip" {
  value = aws_instance.nginx_web_srv_1b.public_ip
}

output "elb_public_dns" {
  value = aws_elb.web_elb.dns_name
}
