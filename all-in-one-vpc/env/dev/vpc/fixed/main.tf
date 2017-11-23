data "aws_availability_zones" "availablity_zones" {}

provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "p915-aws-terraform-state"
    key    = "terraform/one-vpc/dev/vpc.tfstate"
    region = "eu-west-2"
  }
  required_version = "0.10.8"
}

module "app_vpc" {
  source = "../../../../../modules/vpc"

  vpc_cidr    = "${var.app_vpc_cidr}"
  environment = "${var.environment}"
  project_name = "${var.project_name}"
  private_hosted_zone_id = "ZR4R90Y40B111"
}

module "app_subnet_az_1" {
  source = "../../../../../modules/subnet"

  vpc_id = "${module.app_vpc.vpc_id}"
  availability_zone = "${data.aws_availability_zones.availablity_zones.names[0]}"
  public_subnet_cidr = "${var.app_public_subnet_cidr_az_1}"
  private_subnet_cidr = "${var.app_private_subnet_cidr_az_1}"

  environment = "${var.environment}"
  project_name = "${var.project_name}"
}

module "app_subnet_az_2" {
  source = "../../../../../modules/subnet"

  vpc_id = "${module.app_vpc.vpc_id}"
  availability_zone = "${data.aws_availability_zones.availablity_zones.names[1]}"
  public_subnet_cidr = "${var.app_public_subnet_cidr_az_2}"
  private_subnet_cidr = "${var.app_private_subnet_cidr_az_2}"

  environment = "${var.environment}"
  project_name = "${var.project_name}"
}

module "app_internet_gateway" {
  source = "../../../../../modules/internet_gateway"

  vpc_id = "${module.app_vpc.vpc_id}"

  environment = "${var.environment}"
  project_name = "${var.project_name}"
}

module "app_nat_gateway_az_1" {
  source = "../../../../../modules/nat_gateway"
  public_subnet_id = "${module.app_subnet_az_1.public_subnet_id}"

  environment = "${var.environment}"
  project_name = "${var.project_name}"
}

module "app_nat_gateway_az_2" {
  source = "../../../../../modules/nat_gateway"
  public_subnet_id = "${module.app_subnet_az_2.public_subnet_id}"

  environment = "${var.environment}"
  project_name = "${var.project_name}"
}

module "app_routing_tables_az_1" {
  source = "../../../../../modules/route_table"

  vpc_id = "${module.app_vpc.vpc_id}"
  public_subnet_id = "${module.app_subnet_az_1.public_subnet_id}"
  private_subnet_id = "${module.app_subnet_az_1.private_subnet_id}"
  availability_zone = "${data.aws_availability_zones.availablity_zones.names[0]}"

  environment = "${var.environment}"
  project_name = "${var.project_name}"
}

module "app_routing_tables_az_2" {
  source = "../../../../../modules/route_table"

  vpc_id = "${module.app_vpc.vpc_id}"
  public_subnet_id = "${module.app_subnet_az_2.public_subnet_id}"
  private_subnet_id = "${module.app_subnet_az_2.private_subnet_id}"
  availability_zone = "${data.aws_availability_zones.availablity_zones.names[1]}"

  environment = "${var.environment}"
  project_name = "${var.project_name}"
}

module "app_routes_az_1" {
  source = "../../../../../modules/route"

  private_routing_table_id = "${module.app_routing_tables_az_1.private_routing_table_id}"
  public_routing_table_id = "${module.app_routing_tables_az_1.public_routing_table_id}"
  internet_gateway_id = "${module.app_internet_gateway.internet_gateway_id}"
  nat_gateway_id = "${module.app_nat_gateway_az_1.nat_gateway_id}"
}

module "app_routes_az_2" {
  source = "../../../../../modules/route"

  private_routing_table_id = "${module.app_routing_tables_az_2.private_routing_table_id}"
  public_routing_table_id = "${module.app_routing_tables_az_2.public_routing_table_id}"
  internet_gateway_id = "${module.app_internet_gateway.internet_gateway_id}"
  nat_gateway_id = "${module.app_nat_gateway_az_2.nat_gateway_id}"
}

//app_alb

//module "app_alb" {
//  source = "../../../../../modules/alb"
//
//  environment = "${var.environment}"
//  environment_type = "${var.environment_type}"
//  vpc_id = "${module.app_vpc.vpc_id}"
//  alb_security_group_id = "${aws_security_group.alb_security_group.id}"
//  certificate_arn = "${var.certificate_arn}"
//  ssl_policy = "${var.ssl_policy}"
//  route53_hosted_zone_id = "${var.route53_hosted_zone_id}"
//  private_hosted_zone_id = "${var.private_hosted_zone_id}"
//  public_subnet_ids = ["${module.app_subnet_az_a.public_subnet_id}", "${module.app_subnet_az_b.public_subnet_id}", "${module.app_subnet_az_c.public_subnet_id}"]
//  tier = "application"
//  major_version = "0"
//  minor_version = "0"
//  build = "0"
//}