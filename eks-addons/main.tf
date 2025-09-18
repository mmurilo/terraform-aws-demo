locals {
  vars = yamldecode(file("../vars.yaml"))
}


module "eks_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.22.0"

  cluster_name      = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_version   = data.terraform_remote_state.eks.outputs.cluster_version
  cluster_endpoint  = data.terraform_remote_state.eks.outputs.cluster_endpoint
  oidc_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn

  enable_aws_load_balancer_controller = true
  enable_cluster_autoscaler           = true
  enable_metrics_server               = true
  enable_cert_manager                 = true

  aws_load_balancer_controller = {
    chart_version = "1.13.4"
    set = [
      {
        name  = "region"
        value = local.vars.aws_region
      },
      {
        name  = "vpcId"
        value = data.terraform_remote_state.vpc.outputs.vpc_id
      }
    ]
  }
  cluster_autoscaler = {
    chart_version = "9.50.1"
  }
  metrics_server = {
    chart_version = "3.13.0"
  }
  cert_manager = {
    chart_version = "v1.18.2"
  }
}
