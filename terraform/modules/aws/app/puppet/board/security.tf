## PUPPETBOARD ELB
resource "aws_security_group" "puppetboard_elb" {
  name        = "${var.owner}_puppet_puppetboard_elb"
  description = "Puppetboard ELB SG"
  vpc_id      = "${var.vpc_id}"

  # PUPPETBOARD HTTP FROM ALL
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ALLOW OUTBAND TRAFFIC
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "${var.owner}_puppet_puppetboard_elb"
    Owner = "${var.owner}"
  }
}
