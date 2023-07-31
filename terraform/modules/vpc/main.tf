
resource "aws_vpc" "poc_vpc" {
  cidr_block = var.vpc_cidr_block
  tags       = {
    Name      = var.vpc_name
    Terraform = true
  }
}

resource "aws_subnet" "poc_subnet" {
  cidr_block = "10.1.0.0/24"
  vpc_id            = aws_vpc.poc_vpc.id
  availability_zone = var.availability_zone_name

  tags = {
    Name      = "PoCSubnet"
    Terraform = true
  }
}

resource "aws_internet_gateway" "poc_gw" {
  vpc_id = aws_vpc.poc_vpc.id

  tags = {
    Name = var.vpc_name
    Terraform = true
  }
}

resource "aws_route_table" "poc_route_table" {
  vpc_id = aws_vpc.poc_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.poc_gw.id
  }
}

resource "aws_route_table_association" "poc_association" {
  subnet_id      = aws_subnet.poc_subnet.id
  route_table_id = aws_route_table.poc_route_table.id
}
