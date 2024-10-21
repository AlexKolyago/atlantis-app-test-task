resource "kubernetes_namespace" "atlantis" {
  provider = kubernetes.eks

  metadata {
    name = var.kubernetes_namespace
  }
}

resource "helm_release" "atlantis" {
  provider = helm.atlantis

  name       = var.atlantis_helm_release_name
  chart      = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  namespace  = var.kubernetes_namespace
  version    = var.atlantis_chart_version

  values = [
    yamlencode({
      github = {
        user          = var.atlantis_github_user
        token         = var.atlantis_github_token
        webhookSecret = var.github_webhook_secret
      }
      atlantis = {
        repoWhitelist = join(",", var.atlantis_repo_whitelist)
      }
      service = {
        type = "LoadBalancer"
      }
      ingress = {
        enabled = false
      }
    })
  ]

  depends_on = [kubernetes_namespace.atlantis]
}

data "kubernetes_service" "atlantis" {
  metadata {
    name      = var.atlantis_helm_release_name
    namespace = var.kubernetes_namespace
  }

  depends_on = [helm_release.atlantis]
}