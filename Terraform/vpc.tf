
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Jenkins-task-02"
  cidr = "10.0.0.0/16"

  azs             = var.availability_zones
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.2.0/24","10.0.3.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.vpc_tags
}