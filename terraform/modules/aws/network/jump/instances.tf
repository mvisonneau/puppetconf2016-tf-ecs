## CLOUDINIT TEMPLATE GENERATION

module "cloudinit" {
  source   = "../../tools/cloudinit/debian"

  hostname       = "${var.prefix}jump01"
  puppet_env     = "${var.puppet_env}"
  puppet_server  = "${var.puppet_server}"
  puppet_version = "${var.puppet_version}"
}

## Create instance

resource "aws_instance" "jump" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${element( split( ",", var.public_subnet_ids ), count.index )}"
  key_name                    = "${var.ssh_key_name}"
  vpc_security_group_ids      = [ "${aws_security_group.jump_host.id}", "${aws_security_group.default.id}" ]
  user_data                   = "${module.cloudinit.rendered}"

  tags {
    Name  = "${var.prefix}jump01"
    Owner = "${var.owner}"
  }

  lifecycle { create_before_destroy = true }
}
