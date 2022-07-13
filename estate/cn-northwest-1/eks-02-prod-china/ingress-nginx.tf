# Note:
#
# The aws_route53_zone creates a DNS zone and
# the aws_acm_certificate creates an ACM certificate
# which is verified using this zone.
#
# However the zone itself does not work until
# its NS records are created in the upstream zone!
#
# This means that when you apply this for the first time
# the aws_acm_certificate will try to validate the ACM
# for 15+ minutes and you need to create the NS records
# manually within that time.

resource "aws_route53_zone" "ingress_nginx" {
  name = var.ingress_nginx_domain_name
}

locals {
  wildcard = ["*.${var.ingress_nginx_domain_name}"]
}

resource "aws_acm_certificate" "ingress_nginx_cert" {
  domain_name       = var.ingress_nginx_domain_name
  validation_method = "DNS"

  subject_alternative_names = concat(local.wildcard, var.ingress_nginx_alternative_cert_hostnames)

  tags = {
    Name = var.ingress_nginx_domain_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "ingress_nginx_cert_validation" {
  name    = tolist(aws_acm_certificate.ingress_nginx_cert.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.ingress_nginx_cert.domain_validation_options)[0].resource_record_type
  zone_id = aws_route53_zone.ingress_nginx.id
  records = [tolist(aws_acm_certificate.ingress_nginx_cert.domain_validation_options)[0].resource_record_value]
  ttl     = 60
}

output "ingress_nginx_acm_certificate_arn" {
  value = aws_acm_certificate.ingress_nginx_cert.arn
}

output "ingress_nginx_zone_ns_servers" {
  value = aws_route53_zone.ingress_nginx.name_servers
}
