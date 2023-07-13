resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_secret" "cloudflare_api_key_secret" {
  metadata {
    name = "cloudflare-api-key-secret"
    namespace = "cert-manager"
  }
  type = "Opaque"

  data = {
    "apiKey" = "${var.cloudflare_api_key}"
  }

  depends_on = [ kubernetes_namespace.cert_manager ]
}

module "cert_manager" {
  source                                 = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "iam.reduan@gmail.com"
  cluster_issuer_name                    = "cert-manager-global"
  cluster_issuer_private_key_secret_name = "cert-manager-private-key"
  
  namespace_name                          = "cert-manager"
  create_namespace                        = false

  cluster_issuer_server                   = "https://acme-v02.api.letsencrypt.org/directory"


  solvers = [
    {
      dns01 = {
        cloudflare = {
          email = "iam.reduan@gmail.com"
          apiKeySecretRef = {
            name = kubernetes_secret.cloudflare_api_key_secret.metadata[0].name
            key  = "apiKey"
          }
        },
      }
      # http01 = {
      #   ingress = {
      #     class = "external-nginx"
      #   },
      # }
    }
  ]

  certificates = {
    "ssl-certificate" = {
      dns_names = ["${var.url_prefix}redevops.store", "${var.url_prefix}auth.redevops.store", "${var.url_prefix}api.redevops.store", "${var.url_prefix}argocd.redevops.store", "${var.url_prefix}grafana.redevops.store"]
    }
  }

  depends_on = [ kubernetes_secret.cloudflare_api_key_secret ]
}

