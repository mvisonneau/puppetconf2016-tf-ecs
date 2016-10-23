#--------------------------------------------------------------
# This module creates all private subnets
#--------------------------------------------------------------

resource "aws_subnet" "private" {
  availability_zone = "${element( split( ",", var.azs ), count.index )}"
  cidr_block        = "${cidrsubnet( var.vpc_cidr, var.bits, ( length( split( ",", var.azs ) ) + count.index ) )}"
  count             = "${length( split( ",", var.azs ) )}"
  vpc_id            = "${var.vpc_id}"

  tags {
    Name            = "${var.owner}_private_${element( split( ",", var.azs ), count.index )}"
    Owner           = "${var.owner}"
  }

  lifecycle { create_before_destroy = true }
}

resource "aws_route_table" "default_to_natgw" {
  count  = "${length( split( ",", var.azs ) )}"
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element( split( ",", var.nat_gateway_ids ), count.index )}"
  }

  tags {
    Name           = "${var.owner}_default_to_natgw_${element( split( ",", var.azs ), count.index )}"
    Owner          = "${var.owner}"
  }

  lifecycle { create_before_destroy = true }
}

resource "aws_route_table_association" "private_subnet_and_default_to_natgw" {
  count          = "${length( split( ",", var.azs ) )}"
  route_table_id = "${element( aws_route_table.default_to_natgw.*.id, count.index )}"
  subnet_id      = "${element( aws_subnet.private.*.id, count.index )}"

  lifecycle { create_before_destroy = true }
}
