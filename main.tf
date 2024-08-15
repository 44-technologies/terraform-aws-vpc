#############################
# AWS VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr.prefix
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }

  lifecycle {
    # prevent_destroy = true
    ignore_changes = all
  }
}


#############
# AWS Internet Gateway
#############
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-igw"
  }
}

#############
# AWS NAT Gateway
#############
resource "aws_eip" "nat_eip" {
  for_each = local.nat_gateways

  lifecycle {
    prevent_destroy       = false
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name}-natgw-eip-${each.key}"
  }

  depends_on = [aws_internet_gateway.internet_gateway]

}

resource "aws_nat_gateway" "nat_gateway" {
  for_each = local.nat_gateways

  subnet_id = module.public_subnet[each.key].id

  allocation_id = aws_eip.nat_eip[each.key].id

  tags = {
    Name = "${var.name}-natgw-${each.key}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  nat_gateway_ids = { for az, idx in local.availability_zones :
    az => (
      var.share_natgateway == false
      ? aws_nat_gateway.nat_gateway[az].id
  : aws_nat_gateway.nat_gateway[local.default_avzone].id) }
}