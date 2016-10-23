data "template_file" "puppetboard_task" {
  template = "${file( "${path.module}/tasks/puppetboard.json" )}"

  vars {
    puppetdb_host       = "${var.puppet_db_fqdn}"
    docker_cpu          = "${var.docker_cpu}"
    docker_image        = "${var.docker_image}"
    docker_memory       = "${var.docker_memory}"
  }
}
