data "template_file" "puppetserver_task" {
  template = "${file( "${path.module}/tasks/puppetserver.json" )}"

  vars {
    ca_server         = "${var.puppet_ca_fqdn}"
    db_server         = "${var.puppet_db_fqdn}"
    dns_alt_names     = "${aws_elb.puppetserver.dns_name}"
    docker_cpu        = "${var.docker_cpu}"
    docker_image_bin  = "${var.docker_image_bin}"
    docker_image_data = "${var.docker_image_data}"
    docker_memory     = "${var.docker_memory}"
    gitlab_project_id = "${var.gitlab_project_id}"
    gitlab_token      = "${var.gitlab_token}"
    gitlab_url        = "${var.gitlab_url}"
  }
}
