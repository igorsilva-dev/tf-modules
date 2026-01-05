locals {
  private_subnets_map = {
    for subnet in var.private_subnets :
    "${subnet.az}-${subnet.cidr_netnum}" => subnet
  }
  public_subnets_by_az = {
    for k, subnet in aws_subnet.public : subnet.availability_zone => subnet
  }
}

resource "aws_subnet" "private" {
  for_each          = local.private_subnets_map
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, each.value.cidr_newbits, each.value.cidr_netnum)
  availability_zone = each.value.az

  tags = merge(
    var.common_tags,
    {
      Name = each.value.subnet_prefix != "" ? "${each.value.subnet_prefix}-private-subnet-${each.value.az}" : "private-subnet-${each.value.az}"
    },
    each.value.tags
  )
}

resource "aws_eip" "nat" {
  for_each = {
    for k, subnet in local.private_subnets_map :
    k => subnet if subnet.create_nat_gw
  }
  domain = "vpc"
  tags = merge(var.common_tags, {
    Name = each.value.subnet_prefix != "" ? "${each.value.subnet_prefix}-nat-eip-${each.value.az}" : "nat-eip-${each.value.az}"
  })
}

resource "aws_nat_gateway" "ngw" {
  for_each = {
    for k, subnet in local.private_subnets_map :
    k => subnet if subnet.create_nat_gw
  }
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = local.public_subnets_by_az[each.value.az].id

  tags = merge(var.common_tags, {
    Name = each.value.subnet_prefix != "" ? "${each.value.subnet_prefix}-ngw-${each.value.az}" : "ngw-${each.value.az}"
  })
}

resource "aws_route_table" "private" {
  for_each = {
    for k, subnet in local.private_subnets_map :
    k => subnet if subnet.create_nat_gw
  }
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[each.key].id
  }

  tags = merge(var.common_tags, {
    Name = each.value.subnet_prefix != "" ? "${each.value.subnet_prefix}-route-table-${each.value.az}" : "route-table-${each.value.az}"
  })
}

resource "aws_route_table_association" "private" {
  for_each = {
    for k, subnet in local.private_subnets_map :
    k => subnet if subnet.create_nat_gw
  }
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}