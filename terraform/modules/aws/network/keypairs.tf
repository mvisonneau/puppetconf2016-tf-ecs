resource "aws_key_pair" "default" {
  key_name   = "${var.owner}_tf"
  public_key = "${var.ssh_public_key}"
}
