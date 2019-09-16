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