terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # S3 Backend
  backend "s3" {
    bucket = "abdallah-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_key_pair" "my_key_pair" {
  key_name = "abdallah-key-abi"
}

# VPC & Subnets Setup
module "vpc" {
  source = "./modules/vpc"

  # vars
  vpc_name                  = "abdallah_vpc"
  cidr_block                = "10.3.0.0/16"
  public_subnet_cidr_block  = ["10.3.1.0/24", "10.3.4.0/24"]
  public_subnet_name        = ["abdallah_public_subnet", "abdallah_public_subnet2"]
  private_subnet_cidr_block = "10.3.2.0/24"
  private_subnet_name       = "abdallah_private_subnet"
  availability_zone         = ["us-east-1a", "us-east-1b"]
  igw_name                  = "abdallah_igw"
  web_sg_name               = "abdallah_web_sg"
  db_sg_name                = "abdallah_db_sg"

  env = "abdallah"
}

### EC2
module "ec2" {
  source = "./modules/ec2"

  # vars
  db_ami             = "ami-005fc0f236362e99f"
  db_instance_type   = "t2.micro"
  db_subnet_id       = module.vpc.public_subnets_ids[0]
  ssh_key_name       = data.aws_key_pair.my_key_pair.key_name
  security_group_ids = [module.vpc.db_sg_id]

  launch_template_name   = "abdallah_wp_terraform_template"
  ami_id                 = "ami-0f0687f32ae1fd23c"
  instance_type          = "t3.small"
  key_name               = data.aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [module.vpc.web_sg_id]

  wordpress_database_name     = "wordpress"
  wordpress_database_user     = "wpuser"
  wordpress_database_password = "wppassword"

  min_size           = 1
  max_size           = 3
  desired_capacity   = 2
  scaling_adjustment = 1
  subnet_ids         = module.vpc.public_subnets_ids
  vpc_id             = module.vpc.vpc_id
  web_sg_id          = module.vpc.web_sg_id

  env = "abdallah"
}