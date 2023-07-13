data "kubernetes_service" "external_nginx" {
  metadata {
    name = "ingress-hostname"
  }
  depends_on = [helm_release.external_nginx]
}


output "ingress_hostname" {
  # value = data.kubernetes_service.external_nginx.status.0.load_balancer.0.ingress.0.hostname
  value = try(data.kubernetes_service.external_nginx.status.0.load_balancer.0.ingress.0.hostname, null)
}


# ---- CERT MANAGER ----

# output "cert_manager_cluster_issuer_name" {
#   value = module.cert_manager.cluster_issuer_name
# }

# output "cert_manager_cluster_issuer_server" {
#   value = module.cert_manager.cluster_issuer_server
# }

# output "namespace_cert_manager" {
#   value = module.cert_manager.namespace
# }

# output "cert_manager_cluster_issuer_private_key_name" {
#   value = module.cert_manager.cluster_issuer_private_key_name
# }


# # output secret name of each certificate created
# output "cert_manager_certificate_secret_name" {
#   value = try(module.cert_manager.certificates[*].secret_name, null)
# }

# ---- CERT MANAGER ----