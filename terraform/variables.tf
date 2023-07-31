variable "aws_region" {
  default = "us-east-2"
}

variable "base_cidr_block" {
  description = "A /20 CIDR range definition, such as 10.1.0.0/20, that the VPC will use"
  default     = "10.1.0.0/20"
}

variable "aws_profile" {
  default = "mmazoni"
}

variable "az" {
  default = "us-east-2a"
}

variable "dns_domain" {
  default = "mmazoni.com"
}

variable "hosted_zone_id" {
  default = "L05545621ZLGGZLYILC9N"
}
