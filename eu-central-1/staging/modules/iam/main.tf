data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "eks_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_admin" {
  name               = var.eks_admin_role_name
  assume_role_policy = data.aws_iam_policy_document.eks_admin_assume_role.json
}

data "aws_iam_policy_document" "eks_admin_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "eks_read_only" {
  name               = var.eks_read_only_role_name
  assume_role_policy = data.aws_iam_policy_document.eks_read_only_assume_role.json
}

data "aws_iam_policy_document" "eks_read_only_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}