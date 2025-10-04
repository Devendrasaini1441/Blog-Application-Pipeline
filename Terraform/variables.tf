variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name tag"
  type        = string
  default     = "blogify"
}

variable "environment" {
  description = "Environment name (staging | production). Use workspace or -var to switch."
  type        = string
  default     = "staging"
}

variable "git_repo" {
  description = "Git repo to clone"
  type        = string
  default     = "https://github.com/RishabhJain2404/blogify-mern-app.git"
}

variable "git_branch" {
  description = "Branch to checkout on instance (usually same as environment)"
  type        = string
  default     = "${var.environment}"
}

variable "ssh_public_key" {
  description = "SSH public key contents for aws_key_pair"
  type        = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "frontend_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "backend_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  description = "SSH key name in AWS (the public key content will be uploaded)"
  type        = string
  default     = "blogify-key"
}

variable "public_key_path" {
  description = "Path to your SSH public key on disk"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "admin_cidr" {
  description = "CIDR for admin SSH access, e.g. 1.2.3.4/32"
  type        = string
  default     = "0.0.0.0/0" # replace with your IP /32 for security
}
