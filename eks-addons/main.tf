locals {
  vars = yamldecode(file("../vars.yaml"))
}


module "eks_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.21.0"

  cluster_name      = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_version   = data.terraform_remote_state.eks.outputs.cluster_version
  cluster_endpoint  = data.terraform_remote_state.eks.outputs.cluster_endpoint
  oidc_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn

  enable_aws_load_balancer_controller = true
  enable_cluster_autoscaler           = true
  enable_metrics_server               = true

  aws_load_balancer_controller = {
    chart_version = "1.13.2"
  }
  cluster_autoscaler = {
    chart_version = "9.46.6"
  }
  metrics_server = {
    chart_version = "3.12.2"
  }
}
