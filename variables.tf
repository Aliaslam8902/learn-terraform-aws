# AWS Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# Networking
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.50.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "10.50.5.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  type        = string
  default     = "10.50.10.0/24"
}

# Instance Configuration
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Key Pairs
variable "linux_key_name" {
  description = "AWS key pair name for Linux LAMP server"
  type        = string
  default     = "linux-key"
}

variable "windows_key_name" {
  description = "AWS key pair name for Windows bastion (RDP password decryption)"
  type        = string
  default     = "windows-key"
}

# Tags
variable "project_name" {
  description = "Project name used for resource tagging"
  type        = string
  default     = "lamp-stack"
}

# Optional: allow restricting RDP access to a specific IP (set in tfvars)
variable "allowed_rdp_cidr" {
  description = "CIDR allowed to RDP into the bastion host"
  type        = string
  default     = "0.0.0.0/0"   # WARNING: open to world; restrict in production
}