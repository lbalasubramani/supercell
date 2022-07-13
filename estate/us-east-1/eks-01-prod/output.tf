output "cluster" {
  description = "Expose all cluster environment outputs"
  value       = module.cluster
}

output "external_dns_role_arn" {
  value = module.cluster.external_dns_role_arn
}

output "r53_hosted_zone_id" {
  value = aws_route53_zone.ingress_nginx.id
}

output "ingress_nginx_domain_name" {
  value = var.ingress_nginx_domain_name
}

output "velero_role_arn" {
  value = module.cluster.velero_role_arn
}
