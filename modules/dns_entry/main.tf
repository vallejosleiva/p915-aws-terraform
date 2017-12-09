resource "aws_route53_record" "ec2_instance_dns_entry" {
  zone_id = "${var.hosted_zone_id}"
  name = "${var.subdomain_name}.javallejos.com"
  type = "A"
  ttl = "300"
  records = ["${var.ec2_instances_private_ip}"]
}
