# VPC
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "aws_access_key" {
  description = "AWS account access_key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS account secret_key"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "atlantis-test"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# IAM
variable "eks_admin_role_name" {
  description = "The name of the IAM role for EKS admin access."
  type        = string
  default     = "eks-admin"
}

variable "eks_read_only_role_name" {
  description = "The name of the IAM role for EKS read-only access."
  type        = string
  default     = "eks-read-only"
}

#EKS
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eks-atlantis-test"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  default     = "1.31"
}

variable "worker_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "worker_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 2
}

variable "worker_desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "The CIDR blocks for public access to the EKS cluster endpoint"
  type        = list(string)
}

# atlantis
variable "github_username" {
  description = "Your GitHub username"
  type        = string
}

variable "github_token" {
  description = "Your GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "github_repository" {
  description = "Your GitHub repository name"
  type        = string
}

variable "github_webhook_secret" {
  description = "Your GitHub webhook secret"
  type        = string
  sensitive   = true
}

# Common
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    environment = "staging"
    owner       = "akaliaha"
    service     = "atlantis"
    managed_by  = "terraform"
  }
}