
#############
# VPC
#############
output "vpc_id" { value = aws_vpc.vpc.id }
output "vpc_cidr" { value = aws_vpc.vpc.cidr_block }
output "vpc_arn" { value = aws_vpc.vpc.arn }

#############
# IGW, NATGW, EIPs
#############
output "internet_gateway_id" { value = aws_internet_gateway.internet_gateway.id }
output "nat_gateway_id" { value = [aws_nat_gateway.nat_gateway] }


#############
# MODULE subnets
#############

