## GLOBAL

variable "azs"                  {}
variable "name"                 {}
variable "owner"                {}
variable "prefix"               {}
variable "region"               {}
variable "ssh_public_key"       {}
variable "tld"                  {}

## CLOUDINIT
variable "puppet_env"           {}
variable "puppet_server"        {}
variable "puppet_version"       {}

## NETWORK

variable "subnet_bits"          {}
variable "vpc_cidr"             {}

variable "jump_ami"             {}
variable "jump_instance_type"   {}
