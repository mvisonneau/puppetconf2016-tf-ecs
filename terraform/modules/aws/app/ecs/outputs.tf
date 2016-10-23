output "autoscale_role_arn" { value = "${aws_iam_role.ecs_autoscale_role.arn}" }
output "cluster_id"         { value = "${aws_ecs_cluster.default.id}" }
output "cluster_name"       { value = "${aws_ecs_cluster.default.name}" }
output "role_arn"           { value = "${aws_iam_role.ecs_role.arn}" }
output "sg_id"              { value = "${aws_security_group.ecs.id}" }
