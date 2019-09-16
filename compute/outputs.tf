output "server_id" {
  value = "${join(", ", aws_instance.webserver.*.id)}"
}

output "server_ip" {
  value = "${join(", ", aws_instance.webserver.*.public_ip)}"
}
