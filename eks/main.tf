locals {
  vars        = yamldecode(file("../vars.yaml"))
  name        = replace("${local.vars.org}-${local.vars.env}", " ", "-")
  allowed_ips = concat(local.vars.eks.allowed_ips, ["${chomp(data.http.myip.response_body)}/32"])
}

module "eks" {
  source = "github.com/mmurilo/terraform-modules//terraform-aws-eks?ref=aws-eks-v0.2.0"

  cluster_name                         = local.name
  cluster_version                      = local.vars.eks.cluster_version
  vpc_id                               = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids                           = data.terraform_remote_state.vpc.outputs.private_subnets # nodes
  control_plane_subnet_ids             = data.terraform_remote_state.vpc.outputs.private_subnets
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = local.allowed_ips
  eks_managed_node_groups              = local.vars.eks.managed_node_groups
  attach_sso_admin_access_entries      = false
}
