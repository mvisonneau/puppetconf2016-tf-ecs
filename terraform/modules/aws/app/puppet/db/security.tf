##
## INSTANCES SECURITY GROUPS
##

## PUPPETDB ELB
resource "aws_security_group" "puppetdb_elb" {
  name        = "${var.owner}_puppet_puppetdb_elb"
  description = "Puppet DB ELB SG"
  vpc_id      = "${var.vpc_id}"

  # PUPPETDB HTTP FROM SECURE SPACE..!
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ] # Should be more secure than that..
  }

  # PUPPETDB HTTPS FROM ALL
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  # ALLOW OUTBAND TRAFFIC
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags {
    Name  = "${var.owner}_puppet_puppetdb_elb"
    Owner = "${var.owner}"
  }
}

##
## PuppetDB RDS SG
##

resource "aws_security_group" "rds" {
  name        = "${var.owner}_puppetdb_rds"
  description = "PuppetDB RDS SG"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${var.ecs_sg_id}"]
  }

  tags {
    Name  = "${var.owner}_rds"
    Owner = "${var.owner}"
  }
}
