resource "aws_ecs_task_definition" "puppetserver" {
  family                = "puppetserver"
  container_definitions = "${data.template_file.puppetserver_task.rendered}"
}

resource "aws_ecs_service" "puppetserver" {
  name            = "${var.owner}_puppetserver"
  cluster         = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.puppetserver.arn}"
  iam_role        = "${var.ecs_role_arn}"
  desired_count   = "${var.desired_count}"

  load_balancer {
    elb_name       = "${aws_elb.puppetserver.name}"
    container_name = "puppetserver_bin"
    container_port = 8140
  }
}

## SERVICE AUTOSCALING

resource "aws_appautoscaling_target" "default" {
  max_capacity       = "${var.max_count}"
  min_capacity       = "${var.desired_count}"
  resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.puppetserver.name}"
  role_arn           = "${var.ecs_autoscale_role_arn}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [
    "aws_ecs_service.puppetserver"
  ]
}

resource "aws_appautoscaling_policy" "up" {
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 150
  metric_aggregation_type = "Maximum"
  name                    = "${aws_ecs_service.puppetserver.name}_scale_up"
  resource_id             = "service/${var.ecs_cluster_name}/${aws_ecs_service.puppetserver.name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment          = 2
  }

  depends_on = [
    "aws_appautoscaling_target.default"
  ]
}

resource "aws_appautoscaling_policy" "down" {
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 150
  metric_aggregation_type = "Maximum"
  name                    = "${aws_ecs_service.puppetserver.name}_scale_down"
  resource_id             = "service/${var.ecs_cluster_name}/${aws_ecs_service.puppetserver.name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment          = -1
  }

  depends_on = [
    "aws_appautoscaling_target.default"
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.ecs_cluster_name}-${aws_ecs_service.puppetserver.name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 40

  dimensions {
    ClusterName = "${var.ecs_cluster_name}"
    ServiceName = "${aws_ecs_service.puppetserver.name}"
  }

  alarm_actions = [
    "${aws_appautoscaling_policy.up.arn}"
  ]

  depends_on = [
    "aws_appautoscaling_policy.up"
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${var.ecs_cluster_name}-${aws_ecs_service.puppetserver.name}-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 1

  dimensions {
    ClusterName = "${var.ecs_cluster_name}"
    ServiceName = "${aws_ecs_service.puppetserver.name}"
  }

  alarm_actions = [
    "${aws_appautoscaling_policy.down.arn}"
  ]

  depends_on = [
    "aws_appautoscaling_policy.down"
  ]
}
