
 output "s3_static_web_site" {
  value = aws_s3_bucket_website_configuration.blog.website_endpoint
}

output "ECS_static_web_site" {
  value = module.alb.dns_name
}
