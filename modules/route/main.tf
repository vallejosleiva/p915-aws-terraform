
resource "aws_route" "route_to_nat_gateway" {
  route_table_id = "${var.private_routing_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${var.nat_gateway_id}"

}

resource "aws_route" "route_to_internet_gateway" {
  route_table_id = "${var.public_routing_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${var.internet_gateway_id}"

}