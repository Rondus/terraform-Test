provider "aws" {
  region = "us-west-2"
}
resource "aws_vpc" "test" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "test"
  }
}
resource "aws_internet_gateway" "test_vpc_igw" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "test_vpc_igw"
  }
}

resource "nat_gateways" "test_vpc_ngw" {
  source  = "claranet/vpc-modules/aws//modules/nat-gateways"
  version = "0.4.0"
  
  vpc_id = aws_vpc.test.id
  subnet_ids   = resource.aws_subnet.test_subnets_ids
  tags = {
    Name = "test_vpc_ngw"
  }
}
# Use NAT Gateways in private subnets to provide internet access

resource "aws_subnet" "private_subnets" {
  count              = length(var.subnets_cidr)
  vpc_id             = aws_vpc.test.id
  nat_gateway_count  = resource.nat_gateways.nat_gateway_count
  nat_gateway_ids    = resource.nat_gateways.nat_gateway_ids
  cidr_block         = element(var.subnets_cidr, count.index)
  subnet_count       = 2  
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "test_subnets_${count.index + 1}"
  }
}

resource "aws_subnet" "test_subnets" {
  count                   = length(var.subnets_cidr)
  vpc_id                  = aws_vpc.test.id
  cidr_block              = element(var.subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "test_subnets_${count.index + 1}"
  }
}

resource "aws_route_table" "test_public_rt" {
  vpc_id = aws_vpc.test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_vpc_igw.id
  }
  tags = {
    Name = "test_vpc_public_rt"
  }
}


resource "aws_route_table_association" "rt_sub_association" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.test_subnets.*.id, count.index)
  route_table_id = aws_route_table.test_public_rt.id
}
