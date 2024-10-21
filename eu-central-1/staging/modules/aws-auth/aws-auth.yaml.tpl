apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${terraform_role_arn}
      username: terraform
      groups:
        - system:masters
    - rolearn: ${eks_admin_role_arn}
      username: eks-admin
      groups:
        - system:masters
    - rolearn: ${eks_read_only_role_arn}
      username: eks-read-only
      groups:
        - system:aggregate-to-view