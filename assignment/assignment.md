# Problem Statement:
Create a VPC, two public subnets, two private subnets, a jump server in a public subnet, and an EKS cluster in private subnets. Also, deploy a Python-based Lambda function in the public subnet to stop and start EC2 instances daily based on a schedule.

## Objective:
### VPC Creation:

Define an AWS VPC to host public and private subnets.
#### Public and Private Subnets Creation:

Create two public subnets.
Create two private subnets.
### Jump Server:

Launch an EC2 instance (jump server) in one of the public subnets.
### EKS Cluster:

Deploy an EKS cluster across the private subnets.
### Scheduled EC2 Management:

Create a Python-based Lambda function.
Deploy the Lambda in a public subnet.
Configure it to stop EC2 instances at 5 PM and start them at 9 AM daily based on a tag.