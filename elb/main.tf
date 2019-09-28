# ---- elb/main.tf -------------
# creating the ELB
resource "aws_elb" "tf_elb" {
  name            = "${var.project_name}-elb"
  subnets         = "${var.subnet_ids}"
  security_groups = ["${var.security_group}"]
  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.lb_protocol}"
  }
  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.timeout}"
    target              = "${var.target}"
    interval            = "${var.interval}"
  }
  cross_zone_load_balancing = true
  idle_timeout              = 400
  connection_draining       = true
  tags = {
    Name = "${var.project_name}-elb"
  }
}
