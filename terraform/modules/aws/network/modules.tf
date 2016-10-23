module "vpc" {
  source = "./vpc"

  cidr   = "${var.vpc_cidr}"
  name   = "${var.name}-vpc"
  region = "${var.region}"
  tld    = "${var.tld}"
}

module "subnet_private" {
  source = "./subnet/private"

  azs             = "${var.azs}"
  bits            = "${var.subnet_bits}"
  nat_gateway_ids = "${module.nat.nat_gateway_ids}"
  owner           = "${var.owner}"
  vpc_id          = "${module.vpc.vpc_id}"
  vpc_cidr        = "${module.vpc.vpc_cidr}"
}

module "subnet_public" {
  source = "./subnet/public"

  azs      = "${var.azs}"
  bits     = "${var.subnet_bits}"
  owner    = "${var.owner}"
  vpc_id   = "${module.vpc.vpc_id}"
  vpc_cidr = "${module.vpc.vpc_cidr}"
}

module "acl" {
  source = "./acl"

  private_subnet_ids = "${module.subnet_private.subnet_ids}"
  public_subnet_ids  = "${module.subnet_public.subnet_ids}"
  vpc_id             = "${module.vpc.vpc_id}"
}

module "jump" {
  source = "./jump"

  ami               = "${var.jump_ami}"
  instance_type     = "${var.jump_instance_type}"
  owner             = "${var.owner}"
  prefix            = "${var.prefix}"
  public_subnet_ids = "${module.subnet_public.subnet_ids}"
  ssh_key_name      = "${aws_key_pair.default.key_name}"
  vpc_cidr          = "${module.vpc.vpc_cidr}"
  vpc_id            = "${module.vpc.vpc_id}"

  puppet_env        = "${var.puppet_env}"
  puppet_server     = "${var.puppet_server}"
  puppet_version    = "${var.puppet_version}"
}

module "nat" {
  source = "./nat"

  azs               = "${var.azs}"
  public_subnet_ids = "${module.subnet_public.subnet_ids}"
}
