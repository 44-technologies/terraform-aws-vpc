variable "name" {}
variable "vpc_id" {}
variable "cidr" {}

variable "availability_zone" {
  type = string
}

# We work with rtable_id, igw_id and natgw_id as lists because we what to use it in count values.
# If we use string values, terraform couldn't determine count value
variable "igw_id" {
  type    = string
  default = ""
}
variable "natgw_id" {
  type    = string
  default = ""
}
variable "rtable_id" {
  type    = string
  default = ""
}
variable "extra_routes" {
  type    = list(any)
  default = []
}