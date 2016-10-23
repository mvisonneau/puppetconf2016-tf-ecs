## VPC
output "vpc_id"             { value = "${module.vpc.vpc_id}" }
output "vpc_cidr"           { value = "${module.vpc.vpc_cidr}" }

## SUBNETS
output "private_subnet_ids" { value = "${module.subnet_private.subnet_ids}" }
output "public_subnet_ids"  { value = "${module.subnet_public.subnet_ids}" }

## JUMP
output "jump_user"          { value = "${module.jump.user}" }
output "jump_private_ip"    { value = "${module.jump.private_ip}" }
output "jump_public_ip"     { value = "${module.jump.public_ip}" }
output "sg_default_id"      { value = "${module.jump.sg_default_id}" } # Should be done in a dedicated module

## NAT
output "nat_gateway_ids"    { value = "${module.nat.nat_gateway_ids}" }

## KEYPAIR
output "ssh_key_name"       { value = "${aws_key_pair.default.key_name}" }
