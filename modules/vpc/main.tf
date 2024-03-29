resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "${var.project_name} ${var.environment}"
    environment = "${var.environment}"
  }
}

resource "aws_route53_zone_association" "private_hosted_zone_app_vpc_association" {
  zone_id = "${var.private_hosted_zone_id}"
  vpc_id = "${aws_vpc.vpc.id}"
}