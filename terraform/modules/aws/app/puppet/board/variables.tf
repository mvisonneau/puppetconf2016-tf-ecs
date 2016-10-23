##
## GLOBAL
##

variable "owner"                       {}
variable "private_subnet_ids"          {}
variable "vpc_id"                      {}

##
## ECS
##

variable "ecs_cluster_id"              {}
variable "ecs_role_arn"                {}

##
## PuppetDB
##

variable "puppet_db_fqdn"              {}

##
## PUPPETBOARD
##

variable "desired_count"               {}
variable "docker_cpu"                  {}
variable "docker_image"                {}
variable "docker_memory"               {}
