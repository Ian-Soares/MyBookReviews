resource "aws_subnet" "public_main_subnet" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = random_shuffle.az_list.result[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    var.tags,
    {
      "Name" = "pub-sb-${var.vpc_name}"
    }
  )
}

resource "aws_default_route_table" "public_rt_default" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = var.rt_route_cidr_block
    gateway_id = aws_internet_gateway.main_gw.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "public_assoc" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public_main_subnet[count.index].id
  route_table_id = aws_default_route_table.public_rt_default.id
}