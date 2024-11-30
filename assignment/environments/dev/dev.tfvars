account = "learning"
environment = "dev"
vpc_cidr = "198.10.0.0/16"
public_subnets = {
    "public-subnet-1" = {
      cidr_block        = "198.10.0.0/24"
      availability_zone = "us-east-1a"
    },
    "public-subnet-2" = {
      cidr_block        = "198.10.1.0/24"
      availability_zone = "us-east-1b"
    }
}
private_subnets = {
    "private-subnet-1" = {
      cidr_block        = "198.10.2.0/24"
      availability_zone = "us-east-1a"
    },
    "private-subnet-2" = {
      cidr_block        = "198.10.3.0/24"
      availability_zone = "us-east-1b"
    }
}
ami_id = "ami-0866a3c8686eaeeba"
instance_type = "t3.micro"
ami_type = "AL2_x86_64"
disk_size = "20"
eks_nodegroup_instance_types = ["t3.medium"]
desired_size = "1"
max_size = "1"
min_size = "0"