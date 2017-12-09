resource "aws_alb" "alb" {
  name            = "${var.environment}-alb-ecs"
  subnets         = ["${var.public_subnet_ids}"]
  security_groups = ["${var.alb_security_group_id}"]
  enable_deletion_protection = true

  tags {
    Name = "LB ${var.environment}"
  }
}

resource "aws_alb_target_group" "default_target_group" {
  name     = "${var.environment}-ecs-default-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_alb_listener" "https_alb_listener" {
  load_balancer_arn = "${aws_alb.alb.id}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy = "${var.ssl_policy}"
  certificate_arn = "${var.certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.default_target_group.id}"
    type             = "forward"
  }
}

resource "aws_route53_record" "app_alb_public_hosted_zone" {
  zone_id = "${var.route53_hosted_zone_id}"
  name = "${var.environment}-alb.javallejos.com"
  type = "A"

  alias {
    name = "${aws_alb.alb.dns_name}"
    zone_id = "${aws_alb.alb.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "app_alb_private_hosted_zone" {
  zone_id = "${var.private_hosted_zone_id}"
  name = "${var.environment}-alb.javallejos.com"
  type = "A"

  alias {
    name = "${aws_alb.alb.dns_name}"
    zone_id = "${aws_alb.alb.zone_id}"
    evaluate_target_health = false
  }
}