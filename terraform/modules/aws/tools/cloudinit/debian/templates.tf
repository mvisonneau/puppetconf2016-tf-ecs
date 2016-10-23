data "template_file" "cloudinit" {
  template = "${file( "${path.module}/templates/default.yml.tpl" )}"

  vars {
    hostname       = "${var.hostname}"
    puppet_env     = "${var.puppet_env}"
    puppet_server  = "${var.puppet_server}"
    puppet_version = "${var.puppet_version}"
  }
}
