# variables.tf

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Name of the project"
  default     = "pod-app"
}