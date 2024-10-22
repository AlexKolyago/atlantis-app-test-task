variable "kubernetes_namespace" {
  description = "Kubernetes namespace where Atlantis will be deployed"
  type        = string
}

variable "atlantis_github_user" {
  description = "GitHub username for Atlantis"
  type        = string
}

variable "atlantis_github_token" {
  description = "GitHub token for Atlantis"
  type        = string
  sensitive   = true
}

variable "atlantis_chart_version" {
  description = "Version of the Atlantis Helm chart"
  type        = string
}

variable "atlantis_helm_release_name" {
  description = "Name of the Atlantis Helm release"
  type        = string
}

variable "github_webhook_secret" {
  description = "Secret for GitHub webhook authentication."
  type        = string
  sensitive   = true
}

variable "atlantis_allow_list" {
  description = "GitHub allow list for Atlantis"
  type        = string
}