resource "aws_ecs_task_definition" "sweety" {
  family                = "sweety"
  container_definitions = "${data.template_file.sweety_task.rendered}"
}

resource "aws_ecs_service" "sweety" {
  name            = "${var.owner}_sweety"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.sweety.arn}"
  desired_count   = "${var.desired_count}"
}
