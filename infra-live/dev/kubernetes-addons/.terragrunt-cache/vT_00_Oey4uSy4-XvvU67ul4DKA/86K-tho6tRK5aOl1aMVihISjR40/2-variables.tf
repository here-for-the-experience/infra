variable "env" {
  description = "Environment name."
  type        = string
}

variable "url_prefix" {
  description = "URL Prefix."
  type        = string
}

variable "deployment_git" {
  description = "Deployment git repo for argocd application"
  type        = string
}

variable "eks_name" {
  description = "Name of the cluster."
  type        = string
}

variable "enable_cluster_autoscaler" {
  description = "Determines whether to deploy cluster autoscaler"
  type        = bool
  default     = false
}

variable "cluster_autoscaler_helm_verion" {
  description = "Cluster Autoscaler Helm verion"
  type        = string
}

variable "openid_provider_arn" {
  description = "IAM Openid Connect Provider ARN"
  type        = string
}


# Cloudflare variables


variable "cloudflare_api_key" {
  type        = string
  description = "Cloudflare API key"
  default     = "ccf78245c15857c9065ed01664eb9457b712d"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account ID"
  default     = "0d02e4af624446bd6a158b0e2e3f0d14"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone ID"
  default     = "4058b34de03d116bae012255883b0f17"
}


variable "load_balancer_dns_name" {
  type        = string
  description = "Load balancer DNS name"
  default     = "k8s-ingress-external-c0979f04dc-3b430434eb08345a.elb.us-east-1.amazonaws.com"
}