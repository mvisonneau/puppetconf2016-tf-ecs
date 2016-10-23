##
## ECS Cluster Configuration
##

## GLOBAL
variable "owner"                       {}
variable "prefix"                      {}
variable "private_subnet_ids"          {}
variable "ssh_key_name"                {}
variable "vpc_id"                      {}

## ECS
variable "ami_id"                      {}
variable "cluster_name"                {}
variable "instance_type"               {}
variable "max_cluster_size"            {}
variable "min_cluster_size"            {}
