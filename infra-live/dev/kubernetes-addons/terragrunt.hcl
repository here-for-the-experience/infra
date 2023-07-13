terraform {
  source = "../../../modules/kubernetes-addons"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  env      = include.env.locals.env
  eks_name = dependency.eks.outputs.eks_name
  openid_provider_arn = dependency.eks.outputs.openid_provider_arn
  deployment_git = "https://github.com/here-for-the-experience/deployment.git"
  url_prefix = "dev."

  enable_cluster_autoscaler      = true
  cluster_autoscaler_helm_verion = "9.28.0"
}

dependency "eks" {
  config_path = "../eks"

  mock_outputs = {
    eks_name            = "demo"
    openid_provider_arn = "arn:aws:iam::123456789012:oidc-provider"
  }
}

generate "helm_provider" {
  path      = "helm-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF

data "aws_eks_cluster" "eks" {
    name = var.eks_name
}

data "aws_eks_cluster_auth" "eks" {
    name = var.eks_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}
EOF
}

# Modifying from here
# ---------------------
generate "kubectl_provider" {
  path      = "kubectl-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF

provider "kubectl" {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
}
EOF
}


generate "kubernetes_provider" {
  path      = "kubernetes-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF

provider "kubernetes" {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
}
EOF
}

generate "cloudflare_provider" {
  path      = "cloudflare-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF

provider "cloudflare" {
  email  = "iam.reduan@gmail.com"
  api_key = "ccf78245c15857c9065ed01664eb9457b712d"
}

EOF
}
# ---------------------
