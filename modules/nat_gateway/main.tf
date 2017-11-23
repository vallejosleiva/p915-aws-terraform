resource "aws_eip" "nat_gateway_eip" {
}

resource "aws_nat_gateway" "nat_gateway" {
  depends_on = ["aws_eip.nat_gateway_eip"]
  allocation_id = "${aws_eip.nat_gateway_eip.id}"
  subnet_id = "${var.public_subnet_id}"

  tags {
    Name = "${var.project_name} ${var.environment} NAT Gateway"
  }
}
