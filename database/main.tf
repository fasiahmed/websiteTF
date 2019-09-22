# RDS subnet group
resource "aws_db_subnet_group" "tf_rds_subnetgroup" {
  name       = "tf_rds_subnetgroup"
  subnet_ids = ["${var.rds_subnets_ids}"]
  tags = {
    Name = "${var.project_name}-db_subnetgroupname"
  }
}

resource "aws_db_instance" "tf_rds_instance" {
  allocated_storage      = "${var.rds_storage_size}"
  engine                 = "${var.rds_engine}"
  engine_version         = "${var.rds_engine_version}"
  instance_class         = "${var.rds_instance_class}"
  name                   = "${var.rds_db_name}"
  username               = "${var.rds_db_user}"
  password               = "${var.rds_db_password}"
  db_subnet_group_name   = "${aws_db_subnet_group.tf_rds_subnetgroup.name}"
  vpc_security_group_ids = ["${var.rds_vpcsecuritygroup_ids}"]
  skip_final_snapshot    = true
}
