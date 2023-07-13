resource "helm_release" "argo-rollouts" {
  name = "argo-rollouts"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  namespace        = "argocd"
  create_namespace = false
  version          = "2.31.0"

  values     = [file("argo-rollout.yaml")]
  depends_on = [helm_release.argocd, helm_release.external_nginx]
}
