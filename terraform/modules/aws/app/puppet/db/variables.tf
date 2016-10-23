##
## GLOBAL
##

variable "owner"                       {}
variable "prefix"                      {}
variable "private_subnet_ids"          {}
variable "vpc_id"                      {}

##
## PuppetCA
##

variable "puppet_ca_fqdn"              {}

##
## ECS
##

variable "ecs_autoscale_role_arn"      {}
variable "ecs_cluster_id"              {}
variable "ecs_cluster_name"            {}
variable "ecs_role_arn"                {}
variable "ecs_sg_id"                   {}

##
## PuppetDB & Puppetboard
##

variable "desired_count"               {}
variable "docker_cpu"                  {}
variable "docker_image"                {}
variable "docker_memory"               {}
variable "max_count"                   {}

##
## PuppetDB RDS
##

variable "rds_instance"                {}
variable "rds_version"                 {}
variable "rds_size"                    {}
variable "rds_name"                    {}
variable "rds_username"                {}
variable "rds_password"                {}
variable "rds_multi_az"                {}
variable "rds_maintenance_window"      {}
variable "rds_backup_window"           {}
variable "rds_backup_retention_period" {}
