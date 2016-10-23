##
## GLOBAL
##

variable "owner"          {}

##
## ECS
##

variable "ecs_cluster_id" {}

##
## PuppetCA
##

variable "puppet_ca_fqdn" {}

##
## PuppetServer
##

variable "puppet_server_fqdn" {}

##
## SWEETY APP
##
variable "desired_count"  {}
variable "docker_cpu"     {}
variable "docker_image"   {}
variable "docker_memory"  {}
variable "run_frequency"  {}
