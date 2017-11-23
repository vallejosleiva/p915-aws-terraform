variable "aws_region" {
  default = "eu-west-2"
}

variable "environment" {
  default = "dev"
}

variable "project_name" {
  default = "all-in-one-vpc"
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

variable "app_public_subnet_cidr_az_2" {
  default = "10.0.1.16/28"
}

variable "app_private_subnet_cidr_az_2" {
  default = "10.0.1.64/28"
}



