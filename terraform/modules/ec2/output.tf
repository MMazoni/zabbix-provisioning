output "ip_address" {
  value = aws_eip.poc_eip.public_ip
}
