variable "vpc_id" {
}

variable "environment" {
}

variable "environment_type" {
}

variable "public_subnet_ids" {
  type = "list"
}

variable "route53_hosted_zone_id" {
}

variable "private_hosted_zone_id" {
}

variable "certificate_arn" {
}

variable "ssl_policy" {
}

variable "tier" {
}

variable "major_version" {
}

variable "minor_version" {
}

variable "build" {
}

variable "status" {
  default = "active"
}

variable "service_id" {
  default = "0"
}

variable "importance" {
  default = "normal"
}

variable "review_date" {
  default = "26/10/2017"
}

variable "application" {
  default = "Customer Profile"
}

variable "costcentre" {
  default = "51754"
}

variable "owner" {
  default = "05_12_UK_Profile@uk.tesco.com"
}

variable "alb_security_group_id" {}