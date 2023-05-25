output "ngw_id" {
    description = "output of NAT Gateway"
    value = aws_nat_gateway.aws_ngw.id
}

output "igw_id" {
    description = "output of Internet Gateway"
    value = aws_internet_gateway.aws_igw.id
}