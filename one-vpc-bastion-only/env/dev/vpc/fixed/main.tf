data "aws_availability_zones" "availablity_zones" {}

provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "p915-aws-terraform-state-s3"
    key    = "terraform/one-vpc-bastion-only/dev/vpc.tfstate"
    region = "us-east-1"
  }
  required_version = "0.10.8"
}

module "app_vpc" {
  source = "../../../../../modules/vpc"

  vpc_cidr    = "${var.app_vpc_cidr}"
  environment = "${var.environment}"
  project_name = "${var.project_name}"
  private_hosted_zone_id = "${var.private_hosted_zone_id}"
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

module "app_routing_tables_az_1" {
  source = "../../../../../modules/route_table"

  vpc_id = "${module.app_vpc.vpc_id}"
  public_subnet_id = "${module.app_subnet_az_1.public_subnet_id}"
  private_subnet_id = "${module.app_subnet_az_1.private_subnet_id}"
  availability_zone = "${data.aws_availability_zones.availablity_zones.names[0]}"

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
