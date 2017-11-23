resource "aws_route_table" "public_routing_table" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.project_name} ${var.environment} Public Routing Table ${var.availability_zone}"
    environment = "${var.environment}"
  }

  tags {
    Name = "${var.project_name} ${var.environment} Public Routing Table ${var.availability_zone}"
  }
}

resource "aws_route_table" "private_routing_table" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.project_name} ${var.environment} Private Routing Table ${var.availability_zone}"
  }
}

resource "aws_route_table_association" "public_subnet_routing_table_association" {
  subnet_id = "${var.public_subnet_id}"
  route_table_id = "${aws_route_table.public_routing_table.id}"
}

resource "aws_route_table_association" "private_subnet_routing_table_association" {
  subnet_id = "${var.private_subnet_id}"
  route_table_id = "${aws_route_table.private_routing_table.id}"
}
