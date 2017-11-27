output "vpc_id"{
   value="${module.app_vpc.vpc_id}"
}

output public_subnet_id"" {
   value = "${module.app_subnet_az_1.public_subnet_id}"
}

output "cidr_block" {
   value = "${module.app_vpc.cidr_block}"
}
