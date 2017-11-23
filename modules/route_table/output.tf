output "public_routing_table_id"{
   value = "${aws_route_table.public_routing_table.id}"
}

output "private_routing_table_id"{
   value = "${aws_route_table.private_routing_table.id}"
}
