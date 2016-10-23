data "template_file" "sweety_task" {
  template = "${file( "${path.module}/tasks/sweety.json" )}"

  vars {
    puppet_ca     = "${var.puppet_ca_fqdn}"
    puppet_server = "${var.puppet_server_fqdn}"
    docker_cpu    = "${var.docker_cpu}"
    docker_image  = "${var.docker_image}"
    docker_memory = "${var.docker_memory}"
    run_frequency = "${var.run_frequency}"
  }
}
