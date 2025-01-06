terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

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

module "vpc" {
  source = "./modules/vpc"

  # vars
  vpc_name   = "abdallah_vpc"
  cidr_block = "10.3.0.0/16"

  env = "abdallah"
}

module "subnets" {
  source = "./modules/subnets"

  # vars
  vpc_id                    = module.vpc.vpc_id
  public_subnet_cidr_block  = ["10.3.1.0/24", "10.3.4.0/24"]
  public_subnet_name        = ["abdallah_public_subnet", "abdallah_public_subnet2"]
  private_subnet_cidr_block = "10.3.2.0/24"
  private_subnet_name       = "abdallah_private_subnet"
  availability_zone         = ["us-east-1a", "us-east-1b"]

  env = "abdallah"
}

module "igw" {
  source = "./modules/igw"

  # vars
  igw_name = "abdallah_igw"
  vpc_id   = module.vpc.vpc_id

  env = "abdallah"
}

module "nat" {
  source = "./modules/nat"

  # vars
  public_subnet_id = module.subnets.public_subnet_id
  nat_name         = "abdallah_nat"

  env = "abdallah"
}

module "security_groups" {
  source = "./modules/security-groups"

  # vars
  vpc_id      = module.vpc.vpc_id
  web_sg_name = "abdallah_web_sg"
  db_sg_name  = "abdallah_db_sg"

  env = "abdallah"
}

module "route_tables" {
  source = "./modules/rtbs"

  # vars
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.igw.igw_id
  nat_id             = module.nat.nat_id
  public_subnet_ids  = module.subnets.public_subnets_ids
  private_subnet_ids = [module.subnets.private_subnet_id]

  env = "abdallah"
}

module "db" {
  source = "./modules/db"

  # vars
  ami                = "ami-005fc0f236362e99f"
  instance_type      = "t2.micro"
  subnet_id          = module.subnets.private_subnet_id
  ssh_key_name       = data.aws_key_pair.my_key_pair.key_name
  security_group_ids = [module.security_groups.db_sg_id]

  env = "abdallah"
}

### EC2

module "launch_template" {
  source = "./modules/launch_template"

  # vars
  launch_template_name   = "abdallah_wp_terraform_template"
  ami_id                 = "ami-0f0687f32ae1fd23c"
  instance_type          = "t3.small"
  key_name               = data.aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [module.security_groups.web_sg_id]

  database_private_ip         = module.db.db_instance_private_ip
  wordpress_database_name     = "wordpress"
  wordpress_database_user     = "wpuser"
  wordpress_database_password = "wppassword"

  env = "abdallah"
}

module "asg" {
  source = "./modules/asg"

  # vars
  min_size           = 1
  max_size           = 3
  desired_capacity   = 2
  scaling_adjustment = 1
  subnet_ids         = module.subnets.public_subnets_ids
  vpc_id             = module.vpc.vpc_id
  web_sg_id          = module.security_groups.web_sg_id
  launch_template_id = module.launch_template.launch_template_id

  env = "abdallah"
}