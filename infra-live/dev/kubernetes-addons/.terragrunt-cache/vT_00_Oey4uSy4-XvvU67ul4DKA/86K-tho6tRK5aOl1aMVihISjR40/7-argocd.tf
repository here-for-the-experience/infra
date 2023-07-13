resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "3.35.4"

  values     = [file("argocd.yaml")]
  depends_on = [helm_release.external_nginx]
}


resource "kubectl_manifest" "argocd_dev_application" {
  yaml_body = <<YAML
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: apps-dev
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: ${var.deployment_git}
    targetRevision: HEAD
    path: ${var.url_prefix == "dev." ? "environments/dev/apps" : "environments/prod/apps"}
  destination:
    server: https://kubernetes.default.svc
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - Validate=true
      - CreateNamespace=false
      - PrunePropagationPolicy=foreground
      - PruneLast=true
YAML

  depends_on = [helm_release.argocd]
}


resource "kubectl_manifest" "argocd_network" {
  yaml_body = <<YAML
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-argo-1
  namespace: argocd
  annotations:
    nginx.ingress.kubernetes.io/scheme: internet-facing
    nginx.ingress.kubernetes.io/group-name: ns-net
    nginx.ingress.kubernetes.io/group-order: "2"
    
    ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    cert-manager.io/cluster-issuer: cert-manager-global

    # nginx.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
    
spec:
  ingressClassName: external-nginx
  rules:
    - host: ${var.url_prefix == "dev." ? "dev.argocd.redevops.store" : "argocd.redevops.store"}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: argocd-server
                port:
                  name: https
  
  tls:
  - hosts:
    - ${var.url_prefix == "dev." ? "dev.argocd.redevops.store" : "argocd.redevops.store"}
    secretName: ssl-certificate-tls

YAML

  depends_on = [helm_release.argocd, helm_release.external_nginx, module.cert_manager]
}