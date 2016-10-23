resource "aws_elb" "puppetboard" {
  connection_draining       = false
  cross_zone_load_balancing = true
  internal                  = true
  name                      = "${var.owner}-puppetboard"
  security_groups           = [ "${aws_security_group.puppetboard_elb.id}" ]
  subnets                   = [ "${split( ",", var.private_subnet_ids )}" ]

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold       = 2
    unhealthy_threshold     = 8
    timeout                 = 3
    target                  = "TCP:80"
    interval                = 30
  }

  tags {
    Name  = "${var.owner}_puppetboard_elb"
    Owner = "${var.owner}"
  }
}
