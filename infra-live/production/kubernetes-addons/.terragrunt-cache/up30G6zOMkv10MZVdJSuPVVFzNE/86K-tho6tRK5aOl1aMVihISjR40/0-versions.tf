terraform {
  required_version = ">= 1.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9"
    }
    # Modifying from here
    # ---------------------
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.13.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    # ---------------------
  }
}
