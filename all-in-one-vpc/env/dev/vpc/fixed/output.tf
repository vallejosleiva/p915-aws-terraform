output "app_vpc_id" {
  value = "${module.app_vpc.vpc_id}"
}

output "app_public_routing_table_az_1_id" {
  value = "${module.app_routing_tables_az_1.public_routing_table_id}"
}

output "app_public_routing_table_az_2_id" {
  value = "${module.app_routing_tables_az_2.public_routing_table_id}"
}

output "app_private_routing_table_az_1_id" {
  value = "${module.app_routing_tables_az_1.private_routing_table_id}"
}

output "app_private_routing_table_az_2_id" {
  value = "${module.app_routing_tables_az_2.private_routing_table_id}"
}

output "app_vpc_cidr" {
  value = "${var.app_vpc_cidr}"
}

output "app_subnet_az_1_public_id" {
  value = "${module.app_subnet_az_1.public_subnet_id}"
}

output "app_subnet_az_2_public_id" {
  value = "${module.app_subnet_az_2.public_subnet_id}"
}

output "app_subnet_az_1_private_id" {
  value = "${module.app_subnet_az_1.private_subnet_id}"
}

output "app_subnet_az_2_private_id" {
  value = "${module.app_subnet_az_2.private_subnet_id}"
}

output "app_alb_id" {
  value = "${module.app_alb.alb_id}"
}

output "alb_listener_id" {
  value = "${module.app_alb.alb_listener_id}"
}

output "alb_dns_name" {
  value = "${module.app_alb.alb_dns_name}"
}