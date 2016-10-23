## PUPPETCA ELB
resource "aws_security_group" "puppetca_elb" {
  name        = "${var.owner}_puppet_puppetca_elb"
  description = "Puppet CA ELB SG"
  vpc_id      = "${var.vpc_id}"

  # HTTPS FROM ALL
  ingress {
    from_port   = 8140
    to_port     = 8140
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Might need to reduce this one
  }

  # ALLOW OUTBAND TRAFFIC
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "${var.owner}_puppet_puppetca_elb"
    Owner = "${var.owner}"
  }
}
