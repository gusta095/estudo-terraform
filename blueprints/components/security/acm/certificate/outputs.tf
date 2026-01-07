# ------------------------------------------------------------------------------
# ACM CERTIFICATE
# ------------------------------------------------------------------------------

output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = module.acm.acm_certificate_arn
}

output "acm_validation_domains" {
  description = "The list of distinct domain validation options"
  value       = module.acm.validation_domains
}

output "acm_validation_route53_record_fqdns" {
  description = "The list of FQDNs built using the zone domain and name"
  value       = module.acm.validation_route53_record_fqdns
}
