module "ecs_puppet" {
  source = "./ecs"

  owner              = "${var.owner}"
  prefix             = "${var.prefix}"
  private_subnet_ids = "${var.private_subnet_ids}"
  ssh_key_name       = "${var.ssh_key_name}"
  vpc_id             = "${var.vpc_id}"

  ami_id             = "${var.ecs_ami_id}"
  cluster_name       = "${var.ecs_puppet_cluster_name}"
  instance_type      = "${var.ecs_puppet_instance_type}"
  max_cluster_size   = "${var.ecs_puppet_max_cluster_size}"
  min_cluster_size   = "${var.ecs_puppet_min_cluster_size}"
}

module "ecs_app" {
  source = "./ecs"

  owner              = "${var.owner}"
  prefix             = "${var.prefix}"
  private_subnet_ids = "${var.private_subnet_ids}"
  ssh_key_name       = "${var.ssh_key_name}"
  vpc_id             = "${var.vpc_id}"

  ami_id             = "${var.ecs_ami_id}"
  cluster_name       = "${var.ecs_app_cluster_name}"
  instance_type      = "${var.ecs_app_instance_type}"
  max_cluster_size   = "${var.ecs_app_max_cluster_size}"
  min_cluster_size   = "${var.ecs_app_min_cluster_size}"
}

module "puppet_ca" {
  source = "./puppet/ca"

  owner              = "${var.owner}"
  private_subnet_ids = "${var.private_subnet_ids}"
  region             = "${var.region}"
  vpc_id             = "${var.vpc_id}"

  ecs_cluster_id     = "${module.ecs_puppet.cluster_id}"
  ecs_role_arn       = "${module.ecs_puppet.role_arn}"

  docker_cpu         = "${var.puppet_ca_docker_cpu}"
  docker_image       = "${var.puppet_ca_docker_image}"
  docker_memory      = "${var.puppet_ca_docker_memory}"
  certs_bucket       = "${var.puppet_ca_certs_bucket}"
}

module "puppet_db" {
  source = "./puppet/db"

  owner                       = "${var.owner}"
  prefix                      = "${var.prefix}"
  private_subnet_ids          = "${var.private_subnet_ids}"
  vpc_id                      = "${var.vpc_id}"

  puppet_ca_fqdn              = "${module.puppet_ca.fqdn}"

  ecs_autoscale_role_arn      = "${module.ecs_puppet.autoscale_role_arn}"
  ecs_cluster_id              = "${module.ecs_puppet.cluster_id}"
  ecs_cluster_name            = "${module.ecs_puppet.cluster_name}"
  ecs_role_arn                = "${module.ecs_puppet.role_arn}"
  ecs_sg_id                   = "${module.ecs_puppet.sg_id}"

  desired_count               = "${var.puppet_db_desired_count}"
  docker_cpu                  = "${var.puppet_db_docker_cpu}"
  docker_image                = "${var.puppet_db_docker_image}"
  docker_memory               = "${var.puppet_db_docker_memory}"
  max_count                   = "${var.puppet_db_max_count}"
  rds_instance                = "${var.puppet_db_rds_instance}"
  rds_version                 = "${var.puppet_db_rds_version}"
  rds_size                    = "${var.puppet_db_rds_size}"
  rds_name                    = "${var.puppet_db_rds_name}"
  rds_username                = "${var.puppet_db_rds_username}"
  rds_password                = "${var.puppet_db_rds_password}"
  rds_multi_az                = "${var.puppet_db_rds_multi_az}"
  rds_maintenance_window      = "${var.puppet_db_rds_maintenance_window}"
  rds_backup_window           = "${var.puppet_db_rds_backup_window}"
  rds_backup_retention_period = "${var.puppet_db_rds_backup_retention_period}"
}

module "puppet_server" {
  source = "./puppet/server"

  owner                  = "${var.owner}"
  private_subnet_ids     = "${var.private_subnet_ids}"
  vpc_id                 = "${var.vpc_id}"

  puppet_ca_fqdn         = "${module.puppet_ca.fqdn}"
  puppet_db_fqdn         = "${module.puppet_db.fqdn}"

  ecs_autoscale_role_arn = "${module.ecs_puppet.autoscale_role_arn}"
  ecs_cluster_id         = "${module.ecs_puppet.cluster_id}"
  ecs_cluster_name       = "${module.ecs_puppet.cluster_name}"
  ecs_role_arn           = "${module.ecs_puppet.role_arn}"

  desired_count          = "${var.puppet_server_desired_count}"
  docker_cpu             = "${var.puppet_server_docker_cpu}"
  docker_image_bin       = "${var.puppet_server_docker_image_bin}"
  docker_image_data      = "${var.puppet_server_docker_image_data}"
  docker_memory          = "${var.puppet_server_docker_memory}"
  gitlab_project_id      = "${var.puppet_server_gitlab_project_id}"
  gitlab_token           = "${var.puppet_server_gitlab_token}"
  gitlab_url             = "${var.puppet_server_gitlab_url}"
  max_count              = "${var.puppet_server_max_count}"
}

module "puppet_board" {
  source = "./puppet/board"

  owner              = "${var.owner}"
  private_subnet_ids = "${var.private_subnet_ids}"
  vpc_id             = "${var.vpc_id}"

  puppet_db_fqdn     = "${module.puppet_db.fqdn}"

  ecs_cluster_id     = "${module.ecs_puppet.cluster_id}"
  ecs_role_arn       = "${module.ecs_puppet.role_arn}"

  desired_count      = "${var.puppet_board_desired_count}"
  docker_cpu         = "${var.puppet_board_docker_cpu}"
  docker_image       = "${var.puppet_board_docker_image}"
  docker_memory      = "${var.puppet_board_docker_memory}"
}

module "sweety" {
  source = "./sweety"

  owner              = "${var.owner}"

  puppet_ca_fqdn     = "${module.puppet_ca.fqdn}"
  puppet_server_fqdn = "${module.puppet_server.fqdn}"

  ecs_cluster_id     = "${module.ecs_app.cluster_id}"

  desired_count      = "${var.sweety_desired_count}"
  docker_cpu         = "${var.sweety_docker_cpu}"
  docker_image       = "${var.sweety_docker_image}"
  docker_memory      = "${var.sweety_docker_memory}"
  run_frequency      = "${var.sweety_run_frequency}"
}
