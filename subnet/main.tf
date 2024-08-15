####################################################
# AWS subnet
resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = local.igw_set
  tags = {
    Name = var.name
    Cidr = var.cidr
  }
  lifecycle {
    # # ignore_changes = all
    # prevent_destroy = true
  }
}

####################################################
# AWS routes
resource "aws_route_table" "route_table" {
  count  = local.create_table
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-rtable"
  }
  lifecycle {
    create_before_destroy = true
    # prevent_destroy       = true
  }
  depends_on = [aws_subnet.subnet]
}

resource "aws_route" "default_igw_route" {
  count  = local.create_table

  route_table_id         = local.rtable_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = local.igw_set ? local.gateway_id : null
  nat_gateway_id         = local.natgw_set ? local.gateway_id : null
  depends_on             = [aws_route_table.route_table]
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = local.rtable_id
  depends_on     = [aws_route_table.route_table]
}
