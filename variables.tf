variable "aws_region" {
  description = "Select the aws region to deploy the infrasture"
  type        = string
}
variable "aws_access_key" {
  description = "select the aws access key based on dev or prod"
  type        = string
}
variable "aws_secret_key" {
  description = "select the aws secret key based on dev or prod"
  type        = string
}
variable "project_name" {
  description = "Describe the project name"
  type        = string
}
variable "vpc_cidr" {
  description = "select the vpc cidr block"
  type        = string
}
variable "route_cidr" {
  description = "Given the list of routes cidr blocks"
  type        = string
}
variable "vpc_dns_switch" {
  description = "describe vpc dns is enable or disable"
  default     = true
}
variable "public_cidrs" {
  type = list
}
variable "private_cidrs" {
  type = list
}
variable "rds_cidr" {
  type = list
}
variable "accessip" {
  description = "Describe the cidr blocks or ip address which will access the aws instances"
  type        = string
}
variable "key_name" {
  description = "describe the Name of the key for webserver"
  type        = string
}
variable "public_key_path" {
  description = "describe the public path of the key for webserver"
  type        = string
}
variable "instance_count" {
  description = "describe the number of webservers to be launch"
  type        = number
}
variable "instanceType" {
  description = "describe the instance type example t1.micro or t1.small"
  type        = string
}
variable "ingress_sg_block" {
  description = "describe the ingress sesurity block"
  type        = list
}
variable "egress_sg_block" {
  description = "describe the egress sesurity block"
  type        = list
}
# RDS -------------------------
variable "rds_storage_size" {
  description = "describe the storage size of the database"
  type        = string
}
variable "rds_engine" {
  description = "describe the type of the database engine"
  type        = string
}
variable "rds_engine_version" {
  description = "describe the version of the database"
  type        = string
}
variable "rds_instance_class" {
  description = "describe the database instance class"
  type        = string
}
variable "rds_db_name" {
  description = "describe the name of the database"
  type        = string
}
variable "rds_db_user" {
  description = "describe the user of the database"
  type        = string
}
variable "rds_db_password" {
  description = "describe the password of the database"
  type        = string
}
#-------------- ELB -----------------
variable "instance_port" {
  description = "Describe the instance webserver port"
  type        = number
}
variable "instance_protocol" {
  description = "Descript the Protocol TCP or HTTP"
  type        = string
}
variable "lb_port" {
  description = "Describe the load balancer external port"
  type        = number
}
variable "lb_protocol" {
  description = "Describe the load balancer protocol TCP or HTTP"
  type        = string
}
variable "healthy_threshold" {
  description = "Describe the Heath of the threshold value"
  type        = number
}
variable "unhealthy_threshold" {
  description = "Describe the  unhealth threshold value"
  type        = number
}
variable "timeout" {
  description = "Describe the timeout of the session"
  type        = number
}
variable "target" {
  description = "Describe the target value"
  type        = string
}
variable "interval" {
  description = "Describe the interval"
  type        = number
}
