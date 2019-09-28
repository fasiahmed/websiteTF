# ---- elb/variables.tf -------------
variable "instance_port" {}
variable "instance_protocol" {}
variable "lb_port" {}
variable "lb_protocol" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}
variable "timeout" {}
variable "target" {}
variable "interval" {}
variable "subnet_ids" {}
variable "security_group" {}
variable "project_name" {}
