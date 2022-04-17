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

resource "aws_subnet" "test_subnets" {
  count                   = length(var.subnets_cidr)
  vpc_id                  = aws_vpc.test.id
  cidr_block              = element(var.subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "test_subnets_${count.index + 1}"
    Tier = "Public"
  }
}

resource "aws_lb" "test_subnets" {
  name               = "basic-load-balancer"
  vpc_id = aws_vpc.test.id
  load_balancer_type = "application"
  subnets  = resource.aws_subnet.test_subnets.ids

  enable_cross_zone_load_balancing = true
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
