resource "aws_key_pair" "poc_keypair" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}

resource "aws_instance" "poc_ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = var.security_groups

  subnet_id = var.subnet_id

  root_block_device {
    volume_size = 30
  }

  tags = {
    Name      = var.instance_name
    Terraform = true
  }
  associate_public_ip_address = true

  key_name = aws_key_pair.poc_keypair.key_name

  provisioner "local-exec" {
    command = "sleep 60 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook main.yml -i terraform.aws_ec2.yml -u ubuntu --key-file ${var.private_key}"
  }
}

resource "aws_eip" "poc_eip" {
  instance = aws_instance.poc_ec2.id
}

resource "aws_route53_record" "poc-ns1" {
  allow_overwrite = true
  zone_id         = var.zone_id
  name            = var.dns_domain
  type            = "A"
  ttl             = "300"
  records         = [aws_eip.poc_eip.public_ip]
}
