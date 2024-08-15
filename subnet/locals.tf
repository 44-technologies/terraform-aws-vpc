locals {
  # We work with rtable_id, igw_id and   as lists because we want to use it in count values.
  # If we use string values, terraform couldn't determine count value
  create_table = length(var.rtable_id) == 0 ? 1 : 0
  rtable_id    = try(aws_route_table.route_table[0].id, var.rtable_id, "")

  igw_set      = length(var.igw_id) > 0 ? true : false
  natgw_set    = length(var.natgw_id) > 0 ? true : false

  gateway_id   = local.igw_set ? var.igw_id : var.natgw_id


}