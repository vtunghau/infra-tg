# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "K8S VPC"
  }
}

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "My VPC - Internet Gateway"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_public_subnet

  tags = {
    Name = "K8S Public Subnet"
  }
}

resource "aws_route_table" "vpc_public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Local Route Table for Public Subnet"
  }
}

resource "aws_eip" "nat_gw_eip" {
  vpc = true

  tags = {
    Name = "K8S EIP"
  }
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public.id
}


resource "aws_route_table_association" "vpc_public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.vpc_public.id
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_private_subnet

  tags = {
    Name = "K8S Isolated Private Subnet"
  }
}

resource "aws_route_table" "vpc_private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Local Route Table for Isolated Private Subnet"
  }
}

resource "aws_route_table_association" "vpc_private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.vpc_private.id
}