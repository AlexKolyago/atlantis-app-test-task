resource "kubernetes_namespace" "atlantis" {
  metadata {
    name = var.kubernetes_namespace
  }
}

resource "helm_release" "atlantis" {
  name       = var.atlantis_helm_release_name
  chart      = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  namespace  = var.kubernetes_namespace
  version    = var.atlantis_chart_version

  values = [
    templatefile("${path.module}/values.yaml", {
      github_user           = var.atlantis_github_user
      github_token          = var.atlantis_github_token
      github_webhook_secret = var.github_webhook_secret
    })
  ]

  depends_on = [
    kubernetes_namespace.atlantis
  ]
}

data "kubernetes_service" "atlantis" {
  metadata {
    name      = var.atlantis_helm_release_name
    namespace = var.kubernetes_namespace
  }

  depends_on = [helm_release.atlantis]
}