##
## VPC
##

resource "aws_vpc" "default" {
  cidr_block           = "${var.cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags      { Name = "${var.name}" }
  lifecycle { create_before_destroy = true }
}

##
## DHCP
##

resource "aws_vpc_dhcp_options" "default" {
  domain_name         = "${var.tld}"
  domain_name_servers = ["AmazonProvidedDNS"]
}

## Associate DHCP options to the VPC
resource "aws_vpc_dhcp_options_association" "default_assoc" {
  vpc_id          = "${aws_vpc.default.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.default.id}"
}

##
## ENDPOINTS
##

## S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id          = "${aws_vpc.default.id}"
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = ["${aws_vpc.default.main_route_table_id}"]
}
