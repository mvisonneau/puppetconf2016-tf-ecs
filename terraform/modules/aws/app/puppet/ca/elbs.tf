resource "aws_elb" "puppetca" {
  connection_draining       = false
  cross_zone_load_balancing = true
  internal                    = true
  name                        = "${var.owner}-puppetca"
  security_groups             = [ "${aws_security_group.puppetca_elb.id}" ]
  subnets                     = [ "${split(",",var.private_subnet_ids)}" ]

  listener {
    instance_port             = 8140
    instance_protocol         = "tcp"
    lb_port                   = 8140
    lb_protocol               = "tcp"
  }

  health_check {
    healthy_threshold         = 2
    unhealthy_threshold       = 8
    timeout                   = 3
    target                    = "TCP:8140"
    interval                  = 30
  }

  tags {
    Name                      = "${var.owner}_puppet_elb_puppetca"
    Owner                     = "${var.owner}"
  }
}
