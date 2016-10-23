resource "aws_security_group" "default" {
  name        = "${var.owner}_default"
  description = "Allow common traffic to instance"
  vpc_id      = "${var.vpc_id}"

  # Allow access from jump host
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.jump_host.id}"]
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    cidr_blocks     = ["${var.vpc_cidr}"]
  }

  # Allow outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name  = "${var.owner}_default"
    owner = "${var.owner}"
  }
}

resource "aws_security_group" "jump_host" {
  name        = "${var.owner}_jump_host"
  description = "Allow all inbound traffic to jump host"
  vpc_id      = "${var.vpc_id}"

  # Allow SSH remote acces
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags {
    Name  = "${var.owner}_jump_host"
    owner = "${var.owner}"
  }
}
