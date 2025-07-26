
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Generate random suffix for unique resource naming
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 bucket for storing static web assets
resource "aws_s3_bucket" "assets_bucket" {
  bucket        = "demo-web-assets-bucket-${random_string.bucket_suffix.result}"
  force_destroy = true

  tags = {
    Name        = "Web Assets Bucket"
    Environment = "dev"
    Project     = "demo-webapp"
    Owner       = "devops-team"
  }
}

# IAM role for EC2 instances to access AWS services
resource "aws_iam_role" "ec2_role" {
  name = "demo-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "EC2 Demo Role"
    Environment = "dev"
    Project     = "demo-webapp"
  }
}

# Attach AWS managed policy for full administrative access
resource "aws_iam_role_policy_attachment" "ec2_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Instance profile to attach IAM role to EC2 instances
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "demo-ec2-profile"
  role = aws_iam_role.ec2_role.name

  tags = {
    Name        = "EC2 Instance Profile"
    Environment = "dev"
    Project     = "demo-webapp"
  }
}

# Security group for web server allowing HTTP traffic
resource "aws_security_group" "web_sg" {
  name        = "demo-web-sg"
  description = "Security group for demo web server"

  # Allow HTTP traffic from anywhere
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Demo Web Security Group"
    Environment = "dev"
    Project     = "demo-webapp"
  }
}

# EC2 instance running a simple web server
resource "aws_instance" "web_server" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (us-east-1)
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Enable detailed monitoring for better observability
  monitoring = true

  # User data script to set up a basic web server
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    
    # Create a simple HTML page
    cat > /var/www/html/index.html << 'HTML'
    <!DOCTYPE html>
    <html>
    <head>
        <title>Demo Web Server</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 40px; }
            .container { max-width: 800px; margin: 0 auto; }
            .header { color: #333; border-bottom: 2px solid #007acc; padding-bottom: 10px; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="header">Demo Web Server</h1>
            <p>This is a demonstration web server running on AWS EC2.</p>
            <p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
            <p>Availability Zone: $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
        </div>
    </body>
    </html>
HTML
  EOF

  tags = {
    Name        = "Demo Web Server"
    Environment = "dev"
    Project     = "demo-webapp"
    Role        = "webserver"
  }
}
