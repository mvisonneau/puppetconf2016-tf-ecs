resource "aws_elb" "puppetdb" {
  connection_draining       = false
  cross_zone_load_balancing = true
  internal                  = true
  name                      = "${var.owner}-puppetdb"
  security_groups           = [ "${aws_security_group.puppetdb_elb.id}" ]
  subnets                   = [ "${split( ",", var.private_subnet_ids )}" ]

  listener {
    instance_port     = 8081
    instance_protocol = "tcp"
    lb_port           = 8081
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 8080
    instance_protocol = "tcp"
    lb_port           = 8080
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold       = 2
    unhealthy_threshold     = 8
    timeout                 = 3
    target                  = "TCP:8081"
    interval                = 30
  }

  tags {
    Name  = "${var.owner}_puppetdb_elb"
    Owner = "${var.owner}"
  }
}
