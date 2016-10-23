output "user"          { value = "ubuntu" }
output "private_ip"    { value = "${aws_instance.jump.private_ip}" }
output "public_ip"     { value = "${aws_instance.jump.public_ip}" }
output "sg_default_id" { value = "${aws_security_group.default.id}" }
