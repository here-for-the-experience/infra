# resource "kubernetes_namespace" "monitoring" {
#   metadata {
#     name = "monitoring"
#   }
# }

resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

resource "helm_release" "kube-prometheus-stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "47.3.0"
  namespace  = "ingress"

  values = [
    file("monitoring.yaml")
    # ,
    # <<EOF
    # prometheusOperator:
    #   prometheus:
    #     additionalServiceMonitors:
    #       - name: nginx-ingress-controller
    #         selector:
    #           matchLabels:
    #             app: external-nginx

    # prometheus:
    #   prometheusSpec:
    #     additionalScrapeConfigs:
    #       - job_name: 'nginx-ingress-controller'
    #         kubernetes_sd_configs:
    #           - role: endpoints
    #             namespaces:
    #               names:
    #                 - ingress
    #         relabel_configs:
    #           - source_labels: [__meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
    #             action: keep
    #             regex: external-nginx;http-metrics
    # EOF
  ]

  depends_on = [kubernetes_namespace.ingress]
}
