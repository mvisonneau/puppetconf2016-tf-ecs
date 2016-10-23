##
## GLOBAL
##

azs                                   = "us-west-1a,us-west-1b"
name                                  = "demo"
owner                                 = "<you!>"
prefix                                = "uw1d-"
region                                = "us-west-1"
ssh_public_key                        = "<your_public_key>"
tld                                   = "us-west-1.compute"

##
## CLOUDINIT
##
puppet_env                            = "production"
puppet_server                         = "puppet"
puppet_version                        = "1.7.0-1xenial"

##
## NETWORK
##

subnet_bits                           = "3"
vpc_cidr                              = "172.16.8.0/24"

# JUMP
jump_instance_type                    = "t2.nano"

##
## APPLICATIONS
##

## ECS - APP
ecs_app_cluster_name                  = "app"
ecs_app_instance_type                 = "t2.medium"
ecs_app_max_cluster_size              = "70"
ecs_app_min_cluster_size              = "30"

## ECS - PUPPET
ecs_puppet_cluster_name               = "puppet"
ecs_puppet_instance_type              = "t2.medium"
ecs_puppet_max_cluster_size           = "30"
ecs_puppet_min_cluster_size           = "10"

## PUPPETCA
puppet_ca_certs_bucket                = "ops-puppetca-certs"
puppet_ca_docker_cpu                  = "2048"
puppet_ca_docker_image                = "mvisonneau/puppetserver:latest"
puppet_ca_docker_memory               = "3954"

## PUPPETSERVER
puppet_server_desired_count           = "2"
puppet_server_docker_cpu              = "2048"
puppet_server_docker_image_bin        = "mvisonneau/puppetserver:latest"
puppet_server_docker_image_data       = "mvisonneau/pptcb:latest"
puppet_server_docker_memory           = "3890"
puppet_server_gitlab_project_id       = "<your_gitlab_project_id>"
puppet_server_gitlab_token            = "<your_gitlab_token>"
puppet_server_gitlab_url              = "<your_gitlab_server>"
puppet_server_max_count               = "20"

## PUPPETDB
puppet_db_desired_count               = "2"
puppet_db_docker_cpu                  = "1024"
puppet_db_docker_image                = "mvisonneau/puppetdb:latest"
puppet_db_docker_memory               = "2048"
puppet_db_max_count                   = "10"
puppet_db_rds_instance                = "db.m4.large"
puppet_db_rds_version                 = "9.5.4"
puppet_db_rds_size                    = "5"
puppet_db_rds_name                    = "puppetdb"
puppet_db_rds_username                = "puppetdb"
puppet_db_rds_password                = "password" # wow, much secure
puppet_db_rds_multi_az                = "false"
puppet_db_rds_maintenance_window      = "Sun:01:00-Sun:04:00"
puppet_db_rds_backup_window           = "11:00-11:45"
puppet_db_rds_backup_retention_period = "3"

## PUPPETBOARD
puppet_board_desired_count            = "2"
puppet_board_docker_cpu               = "128"
puppet_board_docker_image             = "mvisonneau/puppetboard:latest"
puppet_board_docker_memory            = "256"

## SWEETY
sweety_desired_count                  = "1000"
sweety_docker_cpu                     = "48"
sweety_docker_image                   = "mvisonneau/sweety:latest"
sweety_docker_memory                  = "128"
sweety_run_frequency                  = "2" # In minutes
