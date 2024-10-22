### Deployment

```hcl
terraform init
terraform plan
terraform apply
```

### Proof

Terraform output:

![alt text](proof/tf-resources.png)

Atlantis app:

![alt text](proof/atlantis-url.png)

Working webhooks:

![alt text](proof/webhooks.png)

Atlantis synced by PR:

![alt text](proof/atlantis-pr.png)

Atlantis tf plan:

![alt text](proof/tf-atlantis-plan.png)


### NOTES
stuck with kubernetes namespace

```hcl
module.atlantis.kubernetes_namespace.atlantis: Creating...
╷
│ Error: Unauthorized
│
│   with module.atlantis.kubernetes_namespace.atlantis,
│   on modules/atlantis/main.tf line 1, in resource "kubernetes_namespace" "atlantis":
│    1: resource "kubernetes_namespace" "atlantis" {
│
╵
```

UPD: solved by token usage in K8s provider

```hcl
token = data.aws_eks_cluster_auth.cluster.token
```

```hcl
Error: Get "http://localhost/api/v1/namespaces/atlantis-test": dial tcp [::1]:80: connect: connection refused
```
resolved by: ```enable_cluster_creator_admin_permissions = true``` in eks modole

atlantis docs: https://github.com/runatlantis/helm-charts/blob/main/charts/atlantis/values.yaml