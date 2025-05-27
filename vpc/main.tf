locals {
  vars = yamldecode(file("../vars.yaml"))
  name = replace("${local.vars.org}-${local.vars.env}", " ", "-")
}

module "vpc" {
  source = "github.com/mmurilo/terraform-modules//terraform-aws-vpc?ref=aws-vpc-v0.2.0"

  vpc_name                 = local.name
  vpc_cidr                 = local.vars.vpc.vpc_cidr
  private_subnet_cidr_mask = local.vars.vpc.private_subnet_cidr_mask
  vpce_default_interfaces  = []
  vpce_default_gateways    = []
  single_nat_gateway       = true
  one_nat_gateway_per_az   = false
  for_eks                  = true
}
