terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket  = "edu-tfstate"
    key     = "dev/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "sandbox"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

locals {
  cluster_name = "${var.system}-cluster"
}

//data "aws_security_group" "selected" {
//  name = "edu-vpc02-sandbox-sg-web01"
//}
//
//data "aws_subnet" "selected" {
//  filter {
//    name   = "tag:Name"
//    values = ["edu-vpc02-sandbox-public01-az4"]
//  }
//}

module "instance" {
  source                 = "./../modules/instance"
  env                    = var.env
  system                 = var.system
  disable                = var.disable.instance
  ami                    = var.ami
  instance_type          = var.aws.instance_type
  key_name               = var.aws.key_pair.name
  subnet_id              = var.aws.subnet.public.az4.id
  vpc_security_group_ids = var.aws.security_group.ids
  tags                   = var.tags
}
