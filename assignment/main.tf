module "vpc" {
  source          = "./modules/vpc"
  environment     = var.environment
  account         = var.account
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "ec2" {
  source        = "./modules/ec2"
  environment   = var.environment
  account       = var.account
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.Public_Subnet_IDs[0]
}

module "eks" {
  source             = "./modules/eks"
  environment        = var.environment
  account            = var.account
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.Private_Subnet_IDs
  ami_type           = var.ami_type
  disk_size          = var.disk_size
  eks_nodegroup_instance_types     = var.eks_nodegroup_instance_types
  desired_size       = var.desired_size
  max_size           = var.max_size
  min_size           = var.min_size
}

module "lambda" {
  source = "./modules/lambda"
  environment        = var.environment
  account            = var.account
}