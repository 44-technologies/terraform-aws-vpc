locals {
  availability_zones = { for az in var.availability_zones : "${var.region}${az}" => index(var.availability_zones, az) }

  default_avzone = keys(local.availability_zones)[0]

  nat_gateways = { for az, idx in local.availability_zones : az => idx if var.share_natgateway == false || idx == 0 }
}