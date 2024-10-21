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
resource "local_file" "aws_auth_configmap" {
  content = templatefile("${path.module}/modules/aws-auth/aws-auth.yaml.tpl", {
    terraform_role_arn     = data.aws_caller_identity.current.arn
    eks_admin_role_arn     = module.iam.eks_admin_role_arn
    eks_read_only_role_arn = module.iam.eks_read_only_role_arn
  })
  filename = "${path.module}/aws-auth.yaml"
}

resource "null_resource" "apply_aws_auth_configmap" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "kubectl apply -f ${local_file.aws_auth_configmap.filename}"
  }
}

# altantis
module "atlantis" {
  source = "./modules/atlantis"

  atlantis_github_user    = var.github_username
  atlantis_github_token   = var.github_token
  atlantis_repo_whitelist = ["github.com/${var.github_username}/${var.github_repository}"]
  github_webhook_secret   = random_password.webhook_secret.result
  #github_webhook_secret   = var.github_webhook_secret

  providers = {
    kubernetes = kubernetes.eks
    helm       = helm.atlantis
  }
  depends_on = [module.eks]
}

resource "random_password" "webhook_secret" {
  length  = 32
  special = false
}