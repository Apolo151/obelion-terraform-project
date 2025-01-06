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
  public_subnet_cidr_block  = "10.3.1.0/24"
  public_subnet_name        = "abdallah_public_subnet"
  private_subnet_cidr_block = "10.3.2.0/24"
  private_subnet_name       = "abdallah_private_subnet"
  availability_zone         = "us-east-1a"

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
  public_subnet_ids  = [module.subnets.public_subnet_id]
  private_subnet_ids = [module.subnets.private_subnet_id]

  env = "abdallah"
}