output "ubuntu_xenial_hvm" { value = "${data.aws_ami.ubuntu_xenial_hvm.id}" }
output "ecs_optimized_hvm" { value = "${data.aws_ami.ecs_optimized_hvm.id}" }
