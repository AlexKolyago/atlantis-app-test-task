output "atlantis_service_hostname" {
  description = "Hostname of the Atlantis service"
  value       = data.kubernetes_service.atlantis.status[0].load_balancer[0].ingress[0].hostname
}

output "github_webhook_secret" {
  description = "GitHub webhook secret"
  value       = var.github_webhook_secret
  sensitive   = true
}