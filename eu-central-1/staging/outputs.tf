# Network
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

# EKS
output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

# atlantis
output "github_webhook_secret" {
  description = "GitHub webhook secret"
  value       = module.atlantis.github_webhook_secret
  sensitive   = true
}

output "atlantis_service_hostname" {
  description = "Hostname of the Atlantis service"
  value       = module.atlantis.atlantis_service_hostname
}