
 output "s3_bucket_id" {
  value = aws_s3_bucket_website_configuration.blog.website_endpoint
}

output "service_url" {
  value = module.alb.dns_name
}
