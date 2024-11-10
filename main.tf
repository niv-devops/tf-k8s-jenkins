terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65.0"
    }
  }
  required_version = ">= 1.9.5"
}

provider "aws" {
  region = "eu-central-1"
}

data "aws_security_group" "k8s_sg" {
  id ="sg-01ce9a534213c5e9b"
}

resource "aws_instance" "k8s_master" {
  ami           = "ami-0e04bcbe83a83792e"
  instance_type = "t2.micro"

  tags = {
    Name = "k8s_master"
  }

  key_name = "k8s"

  vpc_security_group_ids = [data.aws_security_group.k8s_sg.id]
}

resource "aws_instance" "k8s_worker" {
  ami           = "ami-0e04bcbe83a83792e"
  instance_type = "t2.micro"

  tags = {
    Name = "k8s_worker"
  }

  key_name = "k8s"

  vpc_security_group_ids = [data.aws_security_group.k8s_sg.id]
}
