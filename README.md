# AWS Infrastructure for WordPress Autoscaling Using Terraform

This repository contains Terraform code to provision a highly available, modular AWS environment for hosting a WordPress site. It automates the creation of:

- A custom VPC with public and private subnets
- A Launch Template based on your WordPress AMI
- An Auto Scaling Group (ASG) of t3.small instances behind a Load Balancer, with CPU‑based scaling
- A MySQL 8 database in a private subnet
- Remote state management in S3

All components are organized into reusable modules, enabling clean separation of concerns and easy maintenance.

### Setup
- Ensure you have Terraform installed on your machine. If not, you can download it [here](https://www.terraform.io/downloads.html).
- Ensure you have the aws CLI installed on your machine. If not, you can download it [here](https://aws.amazon.com/cli/).

----

1. Edit the values in the `main.tf` file to match your environment.

2. Bootstrap & Apply

```bash
terraform init
terraform plan   # Review changes
terraform apply  # Provision resources
```

3. Cleanup

```bash
terraform destroy
```
