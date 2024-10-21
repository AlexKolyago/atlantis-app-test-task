variable "eks_admin_role_name" {
  description = "The name of the IAM role for EKS admin access."
  type        = string
}

variable "eks_read_only_role_name" {
  description = "The name of the IAM role for EKS read access."
  type        = string
}