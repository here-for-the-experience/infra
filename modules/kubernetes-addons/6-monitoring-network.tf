resource "kubectl_manifest" "monitoring_network" {
  yaml_body = <<YAML
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: monitoring-network
  namespace: ingress
  annotations:
    nginx.ingress.kubernetes.io/scheme: internet-facing
    nginx.ingress.kubernetes.io/group-name: ns-net
    nginx.ingress.kubernetes.io/group-order: "2"
    
    ingress.kubernetes.io/force-ssl-redirect: "true"
    cert-manager.io/cluster-issuer: cert-manager-global

spec:
  ingressClassName: external-nginx
  rules:
    - host: ${var.url_prefix == "dev." ? "dev.grafana.redevops.store" : "grafana.redevops.store"}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: kube-prometheus-stack-grafana
                port:
                  number: 80
  tls:
  - hosts:
    - ${var.url_prefix == "dev." ? "dev.grafana.redevops.store" : "grafana.redevops.store"}
    secretName: ssl-certificate-tls
YAML

  depends_on = [helm_release.external_nginx]
}