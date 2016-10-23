#--------------------------------------------------------------
# This module creates all resources necessary for the Bastion
#--------------------------------------------------------------

## GLOBAL

variable "ami"                  {}
variable "instance_type"        {}
variable "owner"                {}
variable "prefix"               {}
variable "public_subnet_ids"    {}
variable "ssh_key_name"         {}
variable "vpc_id"               {}
variable "vpc_cidr"             {}

## CLOUD INIT CONFIGURATION
variable "puppet_env"     {}
variable "puppet_server"  {}
variable "puppet_version" {}
