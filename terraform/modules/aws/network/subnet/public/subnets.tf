resource "aws_subnet" "public" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${cidrsubnet( var.vpc_cidr, var.bits, count.index )}"
  availability_zone = "${element( split( ",", var.azs ), count.index )}"
  count             = "${length( split( ",", var.azs ) )}"

  tags {
    Name            = "${var.owner}_public_${element( split( ",", var.azs ), count.index )}"
    Owner           = "${var.owner}"
  }

  lifecycle { create_before_destroy = true }

  # Default behaviour of the subnet
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name  = "${var.owner}_default"
    Owner = "${var.owner}"
  }
}

resource "aws_route_table" "default_to_igw" {
  vpc_id = "${var.vpc_id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name       = "${var.owner}_default_to_igw"
    Owner      = "${var.owner}"
  }

  lifecycle { create_before_destroy = true }
}

resource "aws_route_table_association" "public_subnet_and_default_to_igw" {
  count          = "${length( split( ",", var.azs ) )}"
  subnet_id      = "${element( aws_subnet.public.*.id, count.index )}"
  route_table_id = "${aws_route_table.default_to_igw.id}"

  lifecycle { create_before_destroy = true }
}
