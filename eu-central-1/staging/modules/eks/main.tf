module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = var.instance_types
  }

  eks_managed_node_groups = {
    altantis = {
      instance_types = ["t2.micro"]
      min_size       = var.worker_min_size
      max_size       = var.worker_max_size
      desired_size   = var.worker_desired_capacity
    }
  }

  tags = var.tags
}