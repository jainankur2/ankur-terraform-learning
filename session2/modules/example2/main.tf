module "my_ec2" {
    source = "github.com/jainankur2/ankur-terraform-learning//modules/ec2?ref=main"
    ami_id = "ami-0866a3c8686eaeeba"
}