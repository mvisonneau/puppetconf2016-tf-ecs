## GLOBAL

variable "azs"                                   {}
variable "name"                                  {}
variable "owner"                                 {}
variable "prefix"                                {}
variable "region"                                {}
variable "ssh_public_key"                        {}
variable "tld"                                   {}

## CLOUDINIT
variable "puppet_env"                            {}
variable "puppet_server"                         {}
variable "puppet_version"                        {}

## NETWORK

variable "subnet_bits"                           {}
variable "vpc_cidr"                              {}
variable "jump_instance_type"                    {}

## APP - ECS
variable "ecs_app_cluster_name"                  {}
variable "ecs_app_instance_type"                 {}
variable "ecs_app_max_cluster_size"              {}
variable "ecs_app_min_cluster_size"              {}
variable "ecs_puppet_cluster_name"               {}
variable "ecs_puppet_instance_type"              {}
variable "ecs_puppet_max_cluster_size"           {}
variable "ecs_puppet_min_cluster_size"           {}

## APP - PUPPETCA
variable "puppet_ca_certs_bucket"                {}
variable "puppet_ca_docker_cpu"                  {}
variable "puppet_ca_docker_image"                {}
variable "puppet_ca_docker_memory"               {}

## APP - PUPPETSERVER
variable "puppet_server_desired_count"           {}
variable "puppet_server_docker_cpu"              {}
variable "puppet_server_docker_image_bin"        {}
variable "puppet_server_docker_image_data"       {}
variable "puppet_server_docker_memory"           {}
variable "puppet_server_gitlab_project_id"       {}
variable "puppet_server_gitlab_token"            {}
variable "puppet_server_gitlab_url"              {}
variable "puppet_server_max_count"               {}

## APP - PUPPETDB
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

## APP - PUPPETBOARD
variable "puppet_board_desired_count"            {}
variable "puppet_board_docker_cpu"               {}
variable "puppet_board_docker_image"             {}
variable "puppet_board_docker_memory"            {}

## APP - SWEETY
variable "sweety_desired_count"                  {}
variable "sweety_docker_cpu"                     {}
variable "sweety_docker_image"                   {}
variable "sweety_docker_memory"                  {}
variable "sweety_run_frequency"                  {}

##
## PROVISIONING
##

provider "aws" {
  region = "${var.region}"
}

module "ami" {
  source = "../../../modules/aws/tools/ami"
}

module "network" {
  source = "../../../modules/aws/network"

  azs                = "${var.azs}"
  name               = "${var.name}"
  owner              = "${var.owner}"
  prefix             = "${var.prefix}"
  region             = "${var.region}"
  ssh_public_key     = "${var.ssh_public_key}"
  tld                = "${var.tld}"

  puppet_env         = "${var.puppet_env}"
  puppet_server      = "${var.puppet_server}"
  puppet_version     = "${var.puppet_version}"

  subnet_bits        = "${var.subnet_bits}"
  vpc_cidr           = "${var.vpc_cidr}"

  jump_instance_type = "${var.jump_instance_type}"
  jump_ami           = "${module.ami.ubuntu_xenial_hvm}"
}

module "app" {
  source = "../../../modules/aws/app"

  owner                                 = "${var.owner}"
  prefix                                = "${var.prefix}"
  private_subnet_ids                    = "${module.network.private_subnet_ids}"
  region                                = "${var.region}"
  ssh_key_name                          = "${module.network.ssh_key_name}"
  vpc_id                                = "${module.network.vpc_id}"

  puppet_env                            = "${var.puppet_env}"
  puppet_server                         = "${var.puppet_server}"
  puppet_version                        = "${var.puppet_version}"

  ecs_ami_id                            = "${module.ami.ecs_optimized_hvm}"
  ecs_app_cluster_name                  = "${var.ecs_app_cluster_name}"
  ecs_app_instance_type                 = "${var.ecs_app_instance_type}"
  ecs_app_max_cluster_size              = "${var.ecs_app_max_cluster_size}"
  ecs_app_min_cluster_size              = "${var.ecs_app_min_cluster_size}"
  ecs_puppet_cluster_name               = "${var.ecs_puppet_cluster_name}"
  ecs_puppet_instance_type              = "${var.ecs_puppet_instance_type}"
  ecs_puppet_max_cluster_size           = "${var.ecs_puppet_max_cluster_size}"
  ecs_puppet_min_cluster_size           = "${var.ecs_puppet_min_cluster_size}"

  puppet_ca_certs_bucket                = "${var.puppet_ca_certs_bucket}"
  puppet_ca_docker_cpu                  = "${var.puppet_ca_docker_cpu}"
  puppet_ca_docker_image                = "${var.puppet_ca_docker_image}"
  puppet_ca_docker_memory               = "${var.puppet_ca_docker_memory}"

  puppet_server_desired_count           = "${var.puppet_server_desired_count}"
  puppet_server_docker_cpu              = "${var.puppet_server_docker_cpu}"
  puppet_server_docker_image_bin        = "${var.puppet_server_docker_image_bin}"
  puppet_server_docker_image_data       = "${var.puppet_server_docker_image_data}"
  puppet_server_docker_memory           = "${var.puppet_server_docker_memory}"
  puppet_server_gitlab_project_id       = "${var.puppet_server_gitlab_project_id}"
  puppet_server_gitlab_token            = "${var.puppet_server_gitlab_token}"
  puppet_server_gitlab_url              = "${var.puppet_server_gitlab_url}"
  puppet_server_max_count               = "${var.puppet_server_max_count}"

  puppet_db_desired_count               = "${var.puppet_db_desired_count}"
  puppet_db_docker_cpu                  = "${var.puppet_db_docker_cpu}"
  puppet_db_docker_image                = "${var.puppet_db_docker_image}"
  puppet_db_docker_memory               = "${var.puppet_db_docker_memory}"
  puppet_db_max_count                   = "${var.puppet_db_max_count}"
  puppet_db_rds_instance                = "${var.puppet_db_rds_instance}"
  puppet_db_rds_version                 = "${var.puppet_db_rds_version}"
  puppet_db_rds_size                    = "${var.puppet_db_rds_size}"
  puppet_db_rds_name                    = "${var.puppet_db_rds_name}"
  puppet_db_rds_username                = "${var.puppet_db_rds_username}"
  puppet_db_rds_password                = "${var.puppet_db_rds_password}"
  puppet_db_rds_multi_az                = "${var.puppet_db_rds_multi_az}"
  puppet_db_rds_maintenance_window      = "${var.puppet_db_rds_maintenance_window}"
  puppet_db_rds_backup_window           = "${var.puppet_db_rds_backup_window}"
  puppet_db_rds_backup_retention_period = "${var.puppet_db_rds_backup_retention_period}"

  puppet_board_desired_count            = "${var.puppet_board_desired_count}"
  puppet_board_docker_cpu               = "${var.puppet_board_docker_cpu}"
  puppet_board_docker_image             = "${var.puppet_board_docker_image}"
  puppet_board_docker_memory            = "${var.puppet_board_docker_memory}"

  sweety_desired_count                  = "${var.sweety_desired_count}"
  sweety_docker_cpu                     = "${var.sweety_docker_cpu}"
  sweety_docker_image                   = "${var.sweety_docker_image}"
  sweety_docker_memory                  = "${var.sweety_docker_memory}"
  sweety_run_frequency                  = "${var.sweety_run_frequency}"
}
