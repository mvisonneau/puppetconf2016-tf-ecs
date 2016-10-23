##
## GLOBAL
##

variable "owner"              {}
variable "private_subnet_ids" {}
variable "region"             {}
variable "vpc_id"             {}

##
## ECS
##

variable "ecs_cluster_id"     {}
variable "ecs_role_arn"       {}

##
## PuppetCA
##

variable "certs_bucket"       {}
variable "docker_cpu"         {}
variable "docker_image"       {}
variable "docker_memory"      {}
