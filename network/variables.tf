variable "project_name" {}
variable "region" {}
variable "vpc_cidr" {}
variable "route_cidr" {}
variable "public_cidrs" {}
variable "private_cidrs" {}
variable "rds_cidr" {}
variable "accessip" {}
variable "vpc_dns_switch" {
  default = true
}
