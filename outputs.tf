output "s3_web_site_dev" {
  value = module.s3_web_site_dev.s3_static_web_site
}
output "s3_web_site_prod" {
  value = module.s3_web_site_prod.s3_static_web_site
}

output "ECS_static_web_site" {
  value = module.alb.dns_name
}
