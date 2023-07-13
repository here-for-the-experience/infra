# resource "kubernetes_namespace" "ingress" {
#   metadata {
#     name = "ingress"
#     labels = {
#       name = "ingress"
#       monitoring = "prometheus"
#     }
#   }
# }


resource "helm_release" "external_nginx" {
  name = "external"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = false
  version          = "4.7.0"

  # set {
  #   name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
  #   value = "arn:aws:acm:us-east-1:513009454083:certificate/68996ed1-f055-4f38-b940-bfc806a9c2ec"
  # }

  # -- Cert Manager
  set {
    name  = "controller.admissionWebhooks.certManager.enabled"
    value = "true"
  }


  set {
    name  = "controller.ingressClassResource.name"
    value = "external-nginx"
  }

  # Enable webhook admission controller
  set {
    name  = "controller.admissionWebhooks.enabled"
    value = "true"
  }

  # Enable metrics for prometheus controller
  # ------------------------------------------------
  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
  set {
    name  = "controller.metrics.serviceMonitor.enabled"
    value = "true"
  }
  set {
    name  = "controller.metrics.serviceMonitor.additionalLabels.release"
    value = "kube-prometheus-stack"
  }

  # ------------------------------------------------

  # Set this only if you have already installed the AWS Load Balancer Controller and want VPC native routing.
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "external"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-nlb-target-type"
    value = "ip"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
    value = "internet-facing"
  }

  depends_on = [helm_release.aws-load-balancer-controller, helm_release.kube-prometheus-stack]
  # depends_on = [helm_release.aws-load-balancer-controller]

}
