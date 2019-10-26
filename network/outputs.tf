output "public_security_group" {
  value = "${aws_security_group.tf_public_sg.id}"
}
output "default_security_group" {
  value = "${aws_default_security_group.default.id}"
}
output "private_security_group" {
  value = "${aws_security_group.tf_private_sg.id}"
}
output "rds_security_group" {
  value = "${aws_security_group.tf_rds_sg.id}"
}
output "public_subnets" {
  value = "${aws_subnet.tf_public_subnet[*].id}"
}
output "private_subnets" {
  value = aws_subnet.tf_private_subnet[*].id
}
output "rds_subnets" {
  value = aws_subnet.tf_rds_subnet[*].id
}
output "private_public_subnetIds" {
  value = join(",", aws_subnet.tf_rds_subnet[*].id)
}
output "allSubnets" {
  value = join(",", aws_subnet.tf_rds_subnet[*].id, aws_subnet.tf_public_subnet[*].id, aws_subnet.tf_private_subnet[*].id)
}
output "public_subnet_ips" {
  value = "${aws_subnet.tf_public_subnet.*.cidr_block}"
}
output "private_subnet_ips" {
  value = "${aws_subnet.tf_private_subnet.*.cidr_block}"
}
output "rds_subnet_ips" {
  value = "${aws_subnet.tf_rds_subnet.*.cidr_block}"
}
output "vpc_endpoint_id" {
  value = "${aws_vpc_endpoint.tf_private_s3endpoint.id}"
}
