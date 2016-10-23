resource "aws_ecs_task_definition" "puppetboard" {
  family                = "puppetboard"
  container_definitions = "${data.template_file.puppetboard_task.rendered}"
}

resource "aws_ecs_service" "puppetboard" {
  name            = "${var.owner}_puppetboard"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.puppetboard.arn}"
  iam_role        = "${var.ecs_role_arn}"
  desired_count   = "${var.desired_count}"

  load_balancer {
    elb_name       = "${aws_elb.puppetboard.name}"
    container_name = "puppetboard"
    container_port = 80
  }
}
