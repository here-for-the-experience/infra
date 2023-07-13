
#  Create CNAME records for the following:
#  - argocd.redevops.store
#  - echo.redevops.store
#  - dev.redevops.store
#  - echo2.redevops.store

# resource "cloudflare_record" "argocd" {
#   zone_id = var.cloudflare_zone_id
#   name    = "argocd"
#   value   = var.load_balancer_dns_name
#   type    = "CNAME"
#   ttl     = 1

#   depends_on = [ helm_release.aws-load-balancer-controller ]
# }

# resource "cloudflare_record" "echo" {
#   zone_id = var.cloudflare_zone_id
#   name    = "echo"
#   value   = var.load_balancer_dns_name
#   type    = "CNAME"
#   ttl     = 1

#   depends_on = [ helm_release.aws-load-balancer-controller ]
# }

# resource "cloudflare_record" "dev" {
#   zone_id = var.cloudflare_zone_id
#   name    = "dev"
#   value   = var.load_balancer_dns_name
#   type    = "CNAME"
#   ttl     = 1

#   depends_on = [ helm_release.aws-load-balancer-controller ]
# }

# resource "cloudflare_record" "echo2" {
#   zone_id = var.cloudflare_zone_id
#   name    = "echo2"
#   value   = var.load_balancer_dns_name
#   type    = "CNAME"
#   ttl     = 1

#   depends_on = [ helm_release.aws-load-balancer-controller ]
# }


# resource "cloudflare_record" "prom" {
#   zone_id = var.cloudflare_zone_id
#   name    = "prom"
#   value   = var.load_balancer_dns_name
#   type    = "CNAME"
#   ttl     = 1

#   depends_on = [ helm_release.aws-load-balancer-controller ]
# }

# resource "cloudflare_record" "grafana" {
#   zone_id = var.cloudflare_zone_id
#   name    = "grafana"
#   value   = var.load_balancer_dns_name
#   type    = "CNAME"
#   ttl     = 1

#   depends_on = [ helm_release.aws-load-balancer-controller ]
# }