data "template_file" "cloudinit" {
  template = "${file( "${path.module}/templates/default.yml.tpl" )}"

  vars {
    cluster_name   = "${var.cluster_name}"
  }
}
