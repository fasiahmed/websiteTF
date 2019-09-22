output "public_security_group" {
  value = "${aws_security_group.tf_public_sg.id}"
}
output "dev_security_group" {
  value = "${aws_security_group.tf_public_sg.id}"
}
output "private_security_group" {
  value = "${aws_security_group.tf_private_sg.id}"
}
output "public_subnets" {
  value = "${aws_subnet.tf_public_subnet.*.id}"
}
output "private_subnets" {
  value = "${aws_subnet.tf_private_subnet.*.id}"
}
output "public_subnet_ips" {
  value = "${aws_subnet.tf_public_subnet.*.cidr_block}"
}
output "private_subnet_ips" {
  value = "${aws_subnet.tf_private_subnet.*.cidr_block}"
}
