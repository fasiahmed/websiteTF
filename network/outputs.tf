output "security_group" {
  value = "${aws_security_group.tf_public_sg.id}"
}
output "subnets" {
  value = "${aws_subnet.tf_public_subnet.*.id}"
}
output "subnet_ips" {
  value = "${aws_subnet.tf_public_subnet.*.cidr_block}"
}
