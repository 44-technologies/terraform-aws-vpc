variable "region" {}
variable "name" {
  type = string
}

variable "cidr" {
  type = object({
    prefix  = string
    newbits = number
  })
}

variable "availability_zones" {
  type = list(string)

  validation {
    condition     = alltrue([for az in var.availability_zones : contains(["a", "b", "c", "d", "e"], az)])
    error_message = "Invalid Availability Zone: \"a\", \"b\", \"c\", \"d\", \"e\". Required"
  }
}

# Subnets
variable "share_natgateway" {
  type    = bool
  default = true
}
