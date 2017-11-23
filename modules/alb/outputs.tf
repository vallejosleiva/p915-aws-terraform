output "alb_id" {
  value = "${aws_alb.alb.id}"
}

output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}

output "alb_zone_id" {
  value = "${aws_alb.alb.zone_id}"
}

output "alb_listener_id" {
  value = "${aws_alb_listener.https_alb_listener.id}"
}