
resource "aws_security_group" "compute_cluster_security_group" {
  description = "ECS Compute cluster security group - ${var.environment}"
  vpc_id = "${module.app_vpc.vpc_id}"

  tags {
    Name = "ECS ${var.environment} Compute cluster security group"
    tesco_environment_class = "${var.environment}"
    tesco_environment = "${var.environment}"
  }
}

resource "aws_security_group" "alb_security_group" {
  vpc_id = "${module.app_vpc.vpc_id}"

  tags {
    Name = "alb ${var.environment} security group"
    environment = "${var.environment}"
    tesco_environment_class = "${var.environment}"
    tesco_environment = "${var.environment}"
  }
}

module "security_group_rules_http" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${aws_security_group.compute_cluster_security_group.id}"

  add_https_ingress_rule = 1
  add_https_egress_rule = 1
  add_http_ingress_rule = 1
  add_http_egress_rule = 1
}

module "security_group_rules_ingress_ssh_ecs_bastion" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${aws_security_group.compute_cluster_security_group.id}"

  add_ssh_ingress_rule = 1

  source_security_group_id = "${data.terraform_remote_state}"
}

module "security_group_rules_egress_ssh_bastion_ecs" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${data.terraform_remote_state.management_vpc_state.bastion_security_group_id}"

  add_ssh_egress_rule = 1

  source_security_group_id = "${aws_security_group.compute_cluster_security_group.id}"
}

module "security_group_rules_ingress_ssh_ecs_jenkins" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${aws_security_group.compute_cluster_security_group.id}"

  add_ssh_ingress_rule = 1

  source_security_group_id = "${data.terraform_remote_state.management_vpc_state.jenkins_security_group_id}"
}

module "security_group_rules_egress_ssh_jenkins_ecs" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${data.terraform_remote_state.management_vpc_state.jenkins_security_group_id}"

  add_ssh_egress_rule = 1

  source_security_group_id = "${aws_security_group.compute_cluster_security_group.id}"
}

module "security_group_rules_ingress_ephemeral" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${aws_security_group.compute_cluster_security_group.id}"

  add_ephemeral_ports_ingress_rule = 1

  source_security_group_id = "${aws_security_group.alb_security_group.id}"
}

module "security_group_rules_egress_ephemeral" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${data.terraform_remote_state.data_vpc_state.cassandra_security_group_id}"

  add_ephemeral_ports_egress_rule = 1

  source_security_group_id = "${aws_security_group.compute_cluster_security_group.id}"
}

module "security_group_rules_cassandra" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${aws_security_group.compute_cluster_security_group.id}"

  add_cassandra_egress_rule = 1

  source_security_group_id = "${data.terraform_remote_state.data_vpc_state.cassandra_security_group_id}"
}

module "security_group_rules_cassandra_clients" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${data.terraform_remote_state.data_vpc_state.cassandra_security_group_id}"

  add_cassandra_ingress_rule = 1

  source_security_group_id = "${aws_security_group.compute_cluster_security_group.id}"
}

module "security_group_rules_splunk" {
  source = "../../../../modules/dynamic/security_group_rules"

  security_group_to_apply_to = "${aws_security_group.compute_cluster_security_group.id}"

  add_splunk_egress_rule = 1

}
