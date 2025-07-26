
# Demo Terraform Environment

This repository contains a demonstration Terraform environment showcasing **infra.new's** automated capabilities for detecting and fixing infrastructure drift and policy violations.

## Architecture Overview

This demo environment deploys a simple web application infrastructure on AWS consisting of:

- **EC2 Instance**: Amazon Linux 2 web server with Apache HTTP server
- **Security Group**: Network security rules for the web server
- **S3 Bucket**: Storage for static web assets
- **IAM Role & Instance Profile**: Permissions for the EC2 instance
- **Outputs**: Key infrastructure information and endpoints

## What This Demo Showcases

### 🔄 Automatic Drift Detection & Resolution
infra.new can automatically detect when your actual infrastructure differs from your Terraform configuration and propose fixes to bring them back in sync.

### 🛡️ Policy Violation Detection & Remediation  
infra.new can identify security and compliance issues in your infrastructure configuration and suggest improvements following AWS best practices.

## Getting Started

### Prerequisites
- AWS CLI configured with appropriate credentials
- Terraform >= 1.0 installed
- Access to infra.new platform

### Deployment

1. **Initialize Terraform**
   ```bash
   cd infra/environments/dev
   terraform init
   ```

2. **Review the Plan**
   ```bash
   terraform plan
   ```

3. **Deploy Infrastructure**
   ```bash
   terraform apply
   ```

4. **Access Your Web Application**
   After deployment, visit the URL provided in the `web_application_url` output to see your running web server.

## Demo Scenarios

### Drift Simulation
After deploying the infrastructure, you can simulate real-world drift scenarios by making manual changes through the AWS Console:

- Modify EC2 instance properties (instance type, tags, etc.)
- Update security group rules
- Change S3 bucket configurations

infra.new will detect these changes and help you decide whether to:
- Update your Terraform configuration to match the current state
- Revert the infrastructure to match your configuration
- Apply a hybrid approach

### Policy Violation Detection
The infrastructure may contain configurations that don't follow AWS security best practices. infra.new can automatically:

- Identify potential security vulnerabilities
- Suggest specific remediation steps
- Generate updated Terraform code with improved security posture

## Key Features Demonstrated

- **Real-time Drift Detection**: Continuous monitoring of infrastructure state
- **Intelligent Remediation**: Smart suggestions for resolving drift and violations
- **Code Generation**: Automatic Terraform code updates
- **Best Practices Enforcement**: Alignment with cloud security standards
- **Change Impact Analysis**: Understanding the implications of proposed fixes

## Infrastructure Components

| Resource | Purpose | Configuration |
|----------|---------|---------------|
| EC2 Instance | Web server hosting | t3.micro, Amazon Linux 2 |
| Security Group | Network access control | HTTP (80) inbound access |
| S3 Bucket | Static asset storage | Private bucket with unique naming |
| IAM Role | EC2 service permissions | Administrative access for demo |
| Instance Profile | Role attachment | Links IAM role to EC2 |

## Outputs Reference

After deployment, Terraform provides several useful outputs:

- `web_application_url`: Direct link to your web application
- `web_server_public_ip`: Public IP address of the server
- `assets_bucket_name`: Name of the created S3 bucket
- Additional networking and security identifiers

## Next Steps

1. **Explore Drift Detection**: Make manual changes via AWS Console and see how infra.new detects them
2. **Review Policy Suggestions**: Let infra.new analyze your configuration for security improvements  
3. **Test Remediation**: Apply suggested fixes and observe the results
4. **Scale the Environment**: Add more resources to see drift detection at scale

---

*This demo environment is designed to showcase infra.new's capabilities. For production use, always follow your organization's security and compliance requirements.*
