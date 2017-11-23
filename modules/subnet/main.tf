resource "aws_subnet" "public_subnet" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "${var.availability_zone}"

  tags {
    Name = "${var.project_name} ${var.environment} public subnet ${var.availability_zone}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${var.availability_zone}"

  tags {
    Name = "${var.project_name} ${var.environment} private subnet v2 ${var.availability_zone}"
  }
}
