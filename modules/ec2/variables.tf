variable "ami_id" {
}

variable "number_of_instances" {
  default = 1
}

variable "instance_type" {
}

variable "ssh_access_key"{
}

variable "security_group_id" {
}

variable "subnet_id" {
}

variable "source_dest_check" {
  default = true
}

variable "associate_public_ip_address" {
  default = false
}

variable "root_block_device_size" {
  default = 10
}

variable "project_name" {
}

variable "environment" {
}

variable "instance_name" {
}

variable "ansible_ref_tag_name" {
}

variable "ec2_id" {
  default = "None"
}





