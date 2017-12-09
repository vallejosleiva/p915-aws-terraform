variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  //  Ubuntu Server 16.04 LTS (HVM), SSD Volume Type
  default = "ami-da05a4a0"
}

variable "ssh_access_key" {
  default = "bastion-key-us-east-1"
}

variable "environment" {
  default = "main"
}

variable "project_name" {
  default = "one-vpc-bastion-only"
}

variable "route53_hosted_zone_id" {
  default = "Z14K2XS4F5D7S8"
}

variable "aws_assume_role_arn" {
  default = "arn:aws:iam::149217099458:role/p915-aws-terraform-role"
}

variable "aws_assume_role_session_name" {
  default = "terraform_session_name"
}

variable "aws_assume_role_external_id" {
  default = "external_id_terraform"
}