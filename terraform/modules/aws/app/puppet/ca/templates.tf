data "template_file" "puppetca_task" {
  template = "${file( "${path.module}/tasks/puppetca.json" )}"

  vars {
    dns_alt_names     = "${aws_elb.puppetca.dns_name}"
    docker_cpu        = "${var.docker_cpu}"
    docker_image      = "${var.docker_image}"
    docker_memory     = "${var.docker_memory}"
    bucket            = "${aws_s3_bucket.puppetca_certs.id}"
  }
}
