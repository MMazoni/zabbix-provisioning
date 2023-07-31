output "vpc_id" {
  value = aws_vpc.poc_vpc.id
}

output "subnet_id" {
  value = aws_subnet.poc_subnet.id
}
