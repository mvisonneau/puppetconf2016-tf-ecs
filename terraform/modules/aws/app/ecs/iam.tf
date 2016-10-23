##
## ECS IAM ROLE AND POLICIES
##

resource "aws_iam_role" "ecs_role" {
  name               = "ecs_${var.cluster_name}_role"
  assume_role_policy = "${file( "${path.module}/policies/ecs-role.json" )}"
}

##
## ECS SERVICE SCHEDULER ROLE
##

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "ecs_${var.cluster_name}_service_role_policy"
  policy = "${file( "${path.module}/policies/ecs-service-role-policy.json" )}"
  role   = "${aws_iam_role.ecs_role.id}"
}

##
## EC2 CONTAINER INSTANCE ROLE & POLICY
##

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name   = "ecs_${var.cluster_name}_instance_role_policy"
  policy = "${file( "${path.module}/policies/ecs-instance-role-policy.json" )}"
  role   = "${aws_iam_role.ecs_role.id}"
}


##
## ECS APP AUTOSCALING ROLE
##

resource "aws_iam_role" "ecs_autoscale_role" {
  name               = "ecs_${var.cluster_name}_autoscale_role"
  assume_role_policy = "${file( "${path.module}/policies/ecs-autoscale-role.json" )}"
}

resource "aws_iam_role_policy" "ecs_autoscale_role_policy" {
  name   = "ecs_${var.cluster_name}_autoscale_role_policy"
  policy = "${file( "${path.module}/policies/ecs-autoscale-role-policy.json" )}"
  role   = "${aws_iam_role.ecs_autoscale_role.id}"
}

##
## IAM profile to be used in auto-scaling launch configuration.
##

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs_${var.cluster_name}_instanceprofile"
  path = "/"
  roles = [ "${aws_iam_role.ecs_role.name}" ]
}
