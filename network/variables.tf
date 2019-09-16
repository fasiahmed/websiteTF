variable "project_name" {}
variable "vpc_cidr" {}
variable "route_cidr" {}
variable "public_cidrs" {}
variable "accessip" {}
variable "vpc_dns_switch" {
  default = true
}
