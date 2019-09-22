provider "aws" {
  region = "${var.aws_region}"
  # shared_credentials_file = "/Users/shaik/.aws/credentials"
  # profile                 = "fasi"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}
# deploy the s3 bucket
module "storage" {
  source       = "./storage"
  project_name = "${var.project_name}"
}
# deploy the network
module "network" {
  source        = "./network"
  project_name  = "${var.project_name}"
  region        = "${var.aws_region}"
  vpc_cidr      = "${var.vpc_cidr}"
  route_cidr    = "${var.route_cidr}"
  public_cidrs  = "${var.public_cidrs}"
  private_cidrs = "${var.private_cidrs}"
  accessip      = "${var.accessip}"
}
# deploy "webserver"
module "compute" {
  source          = "./compute"
  project_name    = "${var.project_name}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_count  = "${var.instance_count}"
  instanceType    = "${var.instanceType}"
  security_group  = "${module.network.dev_security_group}"
  subnets         = "${module.network.public_subnets}"
  subnet_ips      = "${module.network.public_subnet_ips}"
}
