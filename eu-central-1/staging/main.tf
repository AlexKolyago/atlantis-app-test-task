# Data source for current AWS account ID
data "aws_caller_identity" "current" {}

# VPC
module "vpc" {
  source = "./modules/vpc"

  vpc_name             = var.vpc_name
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = ["${var.aws_region}a", "${var.aws_region}b"]
  tags                 = var.tags
}

# IAM
module "iam" {
  source = "./modules/iam"

  eks_admin_role_name     = var.eks_admin_role_name
  eks_read_only_role_name = var.eks_read_only_role_name
}

# EKS
module "eks" {
  source = "./modules/eks"

  aws_region                           = var.aws_region
  cluster_name                         = var.cluster_name
  vpc_id                               = module.vpc.vpc_id
  private_subnet_ids                   = module.vpc.private_subnet_ids
  public_subnet_ids                    = module.vpc.public_subnet_ids
  kubernetes_version                   = var.kubernetes_version
  worker_min_size                      = var.worker_min_size
  worker_max_size                      = var.worker_max_size
  worker_desired_capacity              = var.worker_desired_capacity
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  tags                                 = var.tags
}

# EKS auth
module "eks_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "~> 20.0"

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = module.iam.eks_admin_role_arn
      username = "eks-admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = module.iam.eks_read_only_role_arn
      username = "eks-read_only"
      groups   = ["system:aggregate-to-view"]
    }
  ]

  depends_on = [module.eks, module.iam]
}

# altantis
module "atlantis" {
  source = "./modules/atlantis"

  kubernetes_namespace       = "atlantis-test"
  atlantis_helm_release_name = "atlantis"
  atlantis_chart_version     = "5.7.0"

  atlantis_github_user  = var.github_username
  atlantis_github_token = var.github_token
  github_webhook_secret = random_password.webhook_secret.result

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
  depends_on = [module.eks]
}

resource "random_password" "webhook_secret" {
  length  = 32
  special = false
}