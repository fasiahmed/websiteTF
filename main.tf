provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}
#deploy the s3 bucket
module "storage" {
  source       = "./storage"
  project_name = "${var.project_name}"
}
# deploy the network
module "network" {
  source           = "./network"
  project_name     = "${var.project_name}"
  region           = "${var.aws_region}"
  vpc_cidr         = "${var.vpc_cidr}"
  route_cidr       = "${var.route_cidr}"
  public_cidrs     = "${var.public_cidrs}"
  private_cidrs    = "${var.private_cidrs}"
  rds_cidr         = "${var.rds_cidr}"
  accessip         = "${var.accessip}"
  ingress_sg_block = "${var.ingress_sg_block}"
  egress_sg_block  = "${var.egress_sg_block}"
}
# deploy load balancer elb module
module "elb" {
  source              = "./elb"
  project_name        = "${var.project_name}"
  subnet_ids          = "${module.network.public_subnets}"
  security_group      = "${module.network.public_security_group}"
  instance_port       = "${var.instance_port}"
  instance_protocol   = "${var.instance_protocol}"
  lb_port             = "${var.lb_port}"
  lb_protocol         = "${var.lb_protocol}"
  healthy_threshold   = "${var.healthy_threshold}"
  unhealthy_threshold = "${var.unhealthy_threshold}"
  timeout             = "${var.timeout}"
  target              = "${var.target}"
  interval            = "${var.interval}"
}
# deploy "webserver"
module "compute" {
  source          = "./compute"
  project_name    = "${var.project_name}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_count  = "${var.instance_count}"
  instanceType    = "${var.instanceType}"
  security_group  = "${module.network.default_security_group}"
  subnets         = "${module.network.public_subnets}"
  subnet_ips      = "${module.network.public_subnet_ips}"
  s3_bucket_name  = "${module.storage.bucket_out}"
}
# # deploy RDS MysQL
module "database" {
  source                   = "./database"
  project_name             = "${var.project_name}"
  rds_storage_size         = "${var.rds_storage_size}"
  rds_engine               = "${var.rds_engine}"
  rds_engine_version       = "${var.rds_engine_version}"
  rds_instance_class       = "${var.rds_instance_class}"
  rds_db_name              = "${var.rds_db_name}"
  rds_db_user              = "${var.rds_db_user}"
  rds_db_password          = "${var.rds_db_password}"
  rds_subnets_ids          = "${module.network.allSubnets}"
  rds_vpcsecuritygroup_ids = "${module.network.rds_security_group}"
}
