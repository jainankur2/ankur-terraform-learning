#publish vpc id
output "vpc_id" {
  value = aws_vpc.main.id
}
#publish public subnets IDs 
output "Public_Subnet_IDs" {
  value = [for x in aws_subnet.public-subnets : x.id]
}

#publish private subnets IDs 
output "Private_Subnet_IDs" {
  value = [for x in aws_subnet.private-subnets : x.id]
}