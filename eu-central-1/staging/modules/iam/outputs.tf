output "eks_admin_role_arn" {
  value = aws_iam_role.eks_admin.arn
}

output "eks_read_only_role_arn" {
  value = aws_iam_role.eks_read_only.arn
}