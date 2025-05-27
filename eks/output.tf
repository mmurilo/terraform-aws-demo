output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint of the EKS cluster"
  value       = module.eks.eks.cluster_endpoint
}
output "oidc_provider_arn" {
  description = "OIDC provider ARN for the EKS cluster"
  value       = module.eks.eks.oidc_provider_arn
}
output "cluster_version" {
  description = "Version of the EKS cluster"
  value       = module.eks.cluster_version
}
