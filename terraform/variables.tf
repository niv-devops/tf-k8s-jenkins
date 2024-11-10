variable "aws_region" {
    description = "AWS region" 
    type        = string 
    default     = "eu-central-1"
}

variable "vpc_id" {
    description = "The ID of the existing VPC" 
    type        = string
    default = "vpc-09305c0e6f4405f3e"
}

variable "ami_id" {
  description = "AMI ID to use for instances"
  type        = string
  default     = "ami-0084a47cc718c111a"
}

variable "ssh_key_name" {
  description = "key name to connect to isntance"
  type        = string
  default     = "k8s"
}

variable "k8s_worker_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "gitlab_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.large"
}

variable "small_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.small"
}

variable "protocol_sg" {
  description = "The protocol used for Kubernetes security group ingress rules"
  type        = string
  default     = "tcp"
}

variable "control_plane_ports" {
  description = "List of ports for control plane instance ingress rules"
  type        = list(any)
  default     = [22, 80, 6443, 2379, 2380 ,10250, 10259, 10257]
}

variable "worker_ports" {
  description = "List of ports for worker instance ingress rules"
  type        = list(any)
  default     = [22, 80, 5000, 10250, 10256]
}

variable "jenkins_gitlab_ports" {
  description = "List of ports for jankins and gitlab instances ingress rules"
  type        = list(any)
  default     = [22, 80, 443, 2424, 8080]
}