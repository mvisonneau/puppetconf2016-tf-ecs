##
## ECS CLUSTER
##

resource "aws_ecs_cluster" "default" {
  name = "${var.cluster_name}"
}

##
## AUTOSCALING GROUP
##

resource "aws_autoscaling_group" "ecs" {
  name                 = "${var.owner}_ecs_${var.cluster_name}_asg"
  vpc_zone_identifier  = [ "${split( ",", var.private_subnet_ids )}" ]
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  min_size             = "${var.min_cluster_size}"
  max_size             = "${var.max_cluster_size}"

  tag {
    key = "Name"
    value = "${var.prefix}ecs-${var.cluster_name}"
    propagate_at_launch = true
  }

  tag {
    key = "Owner"
    value = "${var.owner}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "up" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.ecs.name}"
  cooldown               = 120
  name                   = "${var.owner}_ecs_${var.cluster_name}_asg_up"
  scaling_adjustment     = 2

  depends_on = [
    "aws_autoscaling_group.ecs"
  ]
}

resource "aws_cloudwatch_metric_alarm" "memory_usage_high" {
  alarm_actions       = [ "${aws_autoscaling_policy.up.arn}" ]
  alarm_description   = "This metric monitors ECS instance usage"
  alarm_name          = "${var.owner}_ecs_${var.cluster_name}_memory_usage_high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions {
    ClusterName = "${aws_ecs_cluster.default.name}"
  }

  depends_on = [
    "aws_autoscaling_policy.up"
  ]
}

resource "aws_autoscaling_policy" "down" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.ecs.name}"
  cooldown               = 120
  name                   = "${var.owner}_ecs_${var.cluster_name}_asg_down"
  scaling_adjustment     = -1

  depends_on = [
    "aws_autoscaling_group.ecs"
  ]
}

resource "aws_cloudwatch_metric_alarm" "memory_usage_low" {
  alarm_actions       = [ "${aws_autoscaling_policy.down.arn}" ]
  alarm_description   = "This metric monitors ECS instances usage"
  alarm_name          = "${var.owner}_ecs_${var.cluster_name}_memory_usage_low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 10

  dimensions {
    ClusterName = "${aws_ecs_cluster.default.name}"
  }

  depends_on = [
    "aws_autoscaling_policy.down"
  ]
}

##
## ECS LAUNCH CONFIGURATION
##

## CLOUDINIT TEMPLATE GENERATION

module "cloudinit" {
  source = "../../tools/cloudinit/ecs"
  cluster_name = "${aws_ecs_cluster.default.name}"
}

resource "aws_launch_configuration" "ecs" {
  name                 = "${var.owner}_ecs_${var.cluster_name}"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.ssh_key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  security_groups      = [ "${aws_security_group.ecs.id}" ]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
  user_data            = "${module.cloudinit.rendered}"
}
