provider "aws" {
  region = "${var.aws_region}"
//  assume_role {
//    role_arn = "${var.aws_assume_role_arn}"
//    session_name = "${var.aws_assume_role_session_name}"
//    external_id = "${var.aws_assume_role_external_id}"
//  }
}

terraform {
  backend "s3" {
    bucket = "p915-aws-terraform-state-s3"
    key    = "terraform/one-vpc-bastion-only/dev/bastion.tfstate"
    region = "us-east-1"
  }
  required_version = "0.10.8"
}

data "terraform_remote_state" "management_vpc_state" {
  backend = "s3"
  config {
    bucket = "p915-aws-terraform-state-s3"
    key    = "terraform/one-vpc-bastion-only/dev/vpc.tfstate"
    region = "us-east-1"
  }
}

module "mngt_ec2_bastion" {
  source = "../../../../../modules/ec2"

  ami_id = "${var.ami_id}"
  ssh_access_key = "${var.ssh_access_key}"
  instance_type = "t2.micro"
  source_dest_check = false
  associate_public_ip_address = true
  instance_name = "bastion"
  ansible_ref_tag_name = "${var.environment}_bastion"
  security_group_id = "${aws_security_group.management_bastion_security_group.id}"
  subnet_id = "${data.terraform_remote_state.management_vpc_state.public_subnet_id}"

  environment = "${var.environment}"
  project_name = "${var.project_name}"
}

module "mngt_ec2_bastion_dns_entry" {
  source = "../../../../../modules/dns_entry"
  hosted_zone_id = "${var.route53_hosted_zone_id}"
  subdomain_name = "openvpn"
  ec2_instances_private_ip = ["${module.mngt_ec2_bastion.ec2_instance_public_ip}"]
}

resource "aws_security_group" "management_bastion_security_group" {
  description = "Security group for one-vpc-bastion-only bastion"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # for vpn
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # for https
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # for apt
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # for ntp (Ubuntu OS time synchronization)
  egress {
    from_port = 123
    to_port = 123
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${data.terraform_remote_state.management_vpc_state.vpc_id}"

  tags {
    Name = "Management bastion security group"
    environment = "${var.environment}"
  }
}