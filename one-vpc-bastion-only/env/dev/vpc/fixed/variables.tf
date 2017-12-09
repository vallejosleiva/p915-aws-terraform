variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {
  default = "dev"
}

variable "project_name" {
  default = "one-vpc-bastion-only"
}

variable "app_vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "app_public_subnet_cidr_az_1" {
  default = "10.0.1.0/28"
}

variable "app_private_subnet_cidr_az_1" {
  default = "10.0.1.48/28"
}

variable "private_hosted_zone_id" {
  default = "Z14K2XS4F5D7S8"
}



