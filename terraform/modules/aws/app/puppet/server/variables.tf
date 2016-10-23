##
## GLOBAL
##

variable "owner"              {}
variable "private_subnet_ids" {}
variable "vpc_id"             {}

##
## PuppetCA
##

variable "puppet_ca_fqdn"     {}

##
## PuppetDB
##

variable "puppet_db_fqdn"     {}

##
## ECS
##

variable "ecs_cluster_id"         {}
variable "ecs_cluster_name"       {}
variable "ecs_role_arn"           {}
variable "ecs_autoscale_role_arn" {}

##
## PuppetServer
##
variable "desired_count"      {}
variable "docker_cpu"         {}
variable "docker_image_bin"   {}
variable "docker_image_data"  {}
variable "docker_memory"      {}
variable "gitlab_project_id"  {}
variable "gitlab_token"       {}
variable "gitlab_url"         {}
variable "max_count"          {}
