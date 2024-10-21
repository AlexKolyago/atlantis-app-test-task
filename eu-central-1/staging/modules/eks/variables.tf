variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs (for load balancers)"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to use for the EKS cluster."
  type        = string
}

variable "instance_types" {
  description = "Type of ec2 instances for the worker group."
  type        = string
  default     = "t2.micro"
}

variable "worker_min_size" {
  description = "Minimum number of nodes for the worker group."
  type        = number
}

variable "worker_max_size" {
  description = "Maximum number of nodes for the worker group."
  type        = number
}

variable "worker_desired_capacity" {
  description = "Desired number of nodes for the worker group."
  type        = number
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "The CIDR blocks for public access to the EKS cluster endpoint"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
}