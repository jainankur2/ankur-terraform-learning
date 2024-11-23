module "my_ec2" {
    source = "./modules/ec2"
    ami_id = "ami-0866a3c8686eaeeba"
    sg_ids = [module.security_group.sg_id]
}

module "security_group" {
    source = "./modules/sg"
}