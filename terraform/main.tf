provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name               = "PoCMonitoring"
  vpc_cidr_block         = var.base_cidr_block
  availability_zone_name = var.az
}


module "security_group" {
  source = "./modules/security_group"

  security_group_name = "PoCSecurityGroup"
  vpc_id              = module.vpc.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  instance_name   = "PoCZabbixInstance"
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.subnet_id
  security_groups = [module.security_group.security_group_id]
  aws_profile     = var.aws_profile
  aws_region      = var.aws_region
  dns_domain      = var.dns_domain
  zone_id         = var.hosted_zone_id
}
