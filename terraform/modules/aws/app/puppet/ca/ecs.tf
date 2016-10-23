resource "aws_ecs_task_definition" "puppetca" {
  family                = "puppetca"
  container_definitions = "${data.template_file.puppetca_task.rendered}"
}

resource "aws_ecs_service" "puppetca" {
  name            = "${var.owner}_puppetca"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.puppetca.arn}"
  iam_role        = "${var.ecs_role_arn}"
  desired_count   = 1

  load_balancer {
    elb_name       = "${aws_elb.puppetca.name}"
    container_name = "puppetca"
    container_port = 8140
  }
}
