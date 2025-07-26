
# Web server outputs
output "web_server_id" {
  description = "ID of the EC2 web server instance"
  value       = aws_instance.web_server.id
}

output "web_server_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "web_server_public_dns" {
  description = "Public DNS name of the web server"
  value       = aws_instance.web_server.public_dns
}

output "web_server_private_ip" {
  description = "Private IP address of the web server"
  value       = aws_instance.web_server.private_ip
}

# Security group outputs
output "web_security_group_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web_sg.id
}

output "web_security_group_arn" {
  description = "ARN of the web server security group"
  value       = aws_security_group.web_sg.arn
}

# S3 bucket outputs
output "assets_bucket_name" {
  description = "Name of the S3 assets bucket"
  value       = aws_s3_bucket.assets_bucket.bucket
}

output "assets_bucket_arn" {
  description = "ARN of the S3 assets bucket"
  value       = aws_s3_bucket.assets_bucket.arn
}

output "assets_bucket_domain_name" {
  description = "Domain name of the S3 assets bucket"
  value       = aws_s3_bucket.assets_bucket.bucket_domain_name
}

# IAM outputs
output "ec2_role_arn" {
  description = "ARN of the EC2 IAM role"
  value       = aws_iam_role.ec2_role.arn
}

output "ec2_instance_profile_arn" {
  description = "ARN of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.arn
}

# Convenience output for accessing the web application
output "web_application_url" {
  description = "URL to access the web application"
  value       = "http://${aws_instance.web_server.public_dns}"
}
