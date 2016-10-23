data "aws_ami" "ubuntu_xenial_hvm" {
  most_recent = true

  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*" ]
  }

  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }

  owners = [ "099720109477" ] # Canonical
}

data "aws_ami" "ecs_optimized_hvm" {
  most_recent = true

  filter {
    name = "name"
    values = [ "amzn-ami-2016.03.j-amazon-ecs-optimized" ]
  }

  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }

  owners = [ "591542846629" ] # Amazon
}
