# Call the setup module to create a random bucket prefix
run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

variables {
  cidr = {
    prefix = "10.33.0.0/16"
    newbits = 8
  }
  region = "eu-west-1"        
  availability_zones = ["a", "b"]

}


# Apply run block to create the bucket
run "create_vpc" {

  variables {
    name = "${run.setup_tests.vpc_name}"
    share_natgateway = true
  }

  # Check that the bucket name is correct
  assert {
    condition     = aws_vpc.vpc.cidr_block == var.cidr.prefix
    error_message = "Invalid CDIR"
  }

  assert {
    condition     = length(aws_nat_gateway.nat_gateway) == 1
    error_message = "Created More Nat Gateway than expected"
  }

}


