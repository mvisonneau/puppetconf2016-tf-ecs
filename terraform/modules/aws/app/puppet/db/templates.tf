data "template_file" "puppetdb_task" {
  template = "${file( "${path.module}/tasks/puppetdb.json" )}"

  vars {
    ca_server           = "${var.puppet_ca_fqdn}"
    dns_alt_names       = "${aws_elb.puppetdb.dns_name}"
    docker_cpu          = "${var.docker_cpu}"
    docker_image        = "${var.docker_image}"
    docker_memory       = "${var.docker_memory}"
    postgresql_host     = "${aws_db_instance.puppetdb.endpoint}"
    postgresql_user     = "${var.rds_username}"
    postgresql_db       = "${var.rds_name}"
    postgresql_password = "${var.rds_password}"
  }
}
