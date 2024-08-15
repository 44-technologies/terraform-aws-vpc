
module "public_subnet" {
  source = "./subnet"

  for_each = local.availability_zones

  name = "${var.name}-public-subnet-${each.key}"

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
  cidr              = cidrsubnet(var.cidr.prefix, var.cidr.newbits, each.value + 1)
  igw_id            = aws_internet_gateway.internet_gateway.id
}


module "app_subnet" {
  source = "./subnet"

  for_each = local.availability_zones

  name = "${var.name}-application-subnet-${each.key}"

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
  cidr              = cidrsubnet(var.cidr.prefix, var.cidr.newbits, each.value + 4)
  natgw_id          = local.nat_gateway_ids[each.key]

}


module "persistence_subnet" {
  source = "./subnet"

  for_each = local.availability_zones

  name = "${var.name}-persistence-subnet-${each.key}"

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key
  cidr              = cidrsubnet(var.cidr.prefix, var.cidr.newbits, each.value + 7)
  natgw_id          = local.nat_gateway_ids[each.key]
}