# Variables for EKS Cluster Configuration with Custom Modules

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}