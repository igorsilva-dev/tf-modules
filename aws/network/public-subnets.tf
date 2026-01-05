resource "aws_subnet" "public" {
  for_each = {
    for subnet in var.public_subnets :
    "${subnet.az}-${subnet.cidr_netnum}" => subnet
  }
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, each.value.cidr_newbits, each.value.cidr_netnum)
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = each.value.subnet_prefix != "" ? "${each.value.subnet_prefix}-public-subnet-${each.value.az}" : "public-subnet-${each.value.az}"
    },
    each.value.tags
  )
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

