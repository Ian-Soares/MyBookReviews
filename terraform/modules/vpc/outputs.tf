output "aws_public_subnet" {
  value = aws_subnet.public_main_subnet.*.id
}

output "aws_private_subnet" {
  value = aws_subnet.private_main_subnet.*.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_1a" {
  value = aws_subnet.public_main_subnet[0].id
}

output "private_subnet_1b" {
  value = aws_subnet.public_main_subnet[1].id
}