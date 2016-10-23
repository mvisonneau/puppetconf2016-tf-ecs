## GLOBAL
variable "owner"                                 {}
variable "prefix"                                {}
variable "private_subnet_ids"                    {}
variable "region"                                {}
variable "ssh_key_name"                          {}
variable "vpc_id"                                {}

## CLOUDINIT
variable "puppet_env"                            {}
variable "puppet_server"                         {}
variable "puppet_version"                        {}

##
## ECS
##

variable "ecs_ami_id"                            {}

## ECS - PUPPET CLUSTER
variable "ecs_puppet_cluster_name"               {}
variable "ecs_puppet_instance_type"              {}
variable "ecs_puppet_max_cluster_size"           {}
variable "ecs_puppet_min_cluster_size"           {}

## ECS - APP CLUSTER
variable "ecs_app_cluster_name"                  {}
variable "ecs_app_instance_type"                 {}
variable "ecs_app_max_cluster_size"              {}
variable "ecs_app_min_cluster_size"              {}

## PUPPETCA
variable "puppet_ca_certs_bucket"                {}
variable "puppet_ca_docker_cpu"                  {}
variable "puppet_ca_docker_image"                {}
variable "puppet_ca_docker_memory"               {}

## PUPPETSERVER
variable "puppet_server_desired_count"           {}
variable "puppet_server_docker_cpu"              {}
variable "puppet_server_docker_image_bin"        {}
variable "puppet_server_docker_image_data"       {}
variable "puppet_server_docker_memory"           {}
variable "puppet_server_gitlab_project_id"       {}
variable "puppet_server_gitlab_token"            {}
variable "puppet_server_gitlab_url"              {}
variable "puppet_server_max_count"               {}

## PUPPETDB
variable "puppet_db_desired_count"               {}
variable "puppet_db_docker_cpu"                  {}
variable "puppet_db_docker_image"                {}
variable "puppet_db_docker_memory"               {}
variable "puppet_db_max_count"                   {}
variable "puppet_db_rds_instance"                {}
variable "puppet_db_rds_version"                 {}
variable "puppet_db_rds_size"                    {}
variable "puppet_db_rds_name"                    {}
variable "puppet_db_rds_username"                {}
variable "puppet_db_rds_password"                {}
variable "puppet_db_rds_multi_az"                {}
variable "puppet_db_rds_maintenance_window"      {}
variable "puppet_db_rds_backup_window"           {}
variable "puppet_db_rds_backup_retention_period" {}

## PUPPETBOARD
variable "puppet_board_desired_count"            {}
variable "puppet_board_docker_cpu"               {}
variable "puppet_board_docker_image"             {}
variable "puppet_board_docker_memory"            {}

## SWEETY
variable "sweety_desired_count"                  {}
variable "sweety_docker_cpu"                     {}
variable "sweety_docker_image"                   {}
variable "sweety_docker_memory"                  {}
variable "sweety_run_frequency"                  {}
