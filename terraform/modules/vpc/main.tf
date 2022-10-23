resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy

  tags = merge(
    var.tags,
    {
      "Name" = var.vpc_name
    }
  )
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      "Name" = "igw-${var.vpc_name}"
    }
  )
}

data "aws_availability_zones" "available" {
}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = 2
}

resource "aws_eip" "nat_gw_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.main_gw]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_main_subnet[0].id

  tags = {
    Name = "nat_gw_${var.vpc_name}"
  }

  depends_on = [aws_internet_gateway.main_gw]
}