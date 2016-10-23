resource "aws_db_instance" "puppetdb" {
  identifier              = "${var.prefix}puppetdb-db01"
  allocated_storage       = "${var.rds_size}"
  engine                  = "postgres"
  engine_version          = "${var.rds_version}"
  port                    = "5432"
  instance_class          = "${var.rds_instance}"
  name                    = "${var.rds_name}"
  username                = "${var.rds_username}"
  password                = "${var.rds_password}"
  multi_az                = "${var.rds_multi_az}"
  maintenance_window      = "${var.rds_maintenance_window}"
  backup_window           = "${var.rds_backup_window}"
  backup_retention_period = "${var.rds_backup_retention_period}"
  db_subnet_group_name    = "${aws_db_subnet_group.puppetdb.name}"
  vpc_security_group_ids  = [ "${aws_security_group.rds.id}" ]
}

resource "aws_db_subnet_group" "puppetdb" {
  name = "puppetdb_pgsql_private_subnet_group"
  description = "PuppetDB Private Subnet Group"
  subnet_ids = ["${split( ",", var.private_subnet_ids )}"]
}
