data "aws_ami" "server_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"] # Canonical
}
resource "aws_key_pair" "mykeypair" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}
# data "template_file" "user-init" {
#   count    = "${var.instance_count}"
#   template = "${file("${path.module}/userdata.tpl")}"
#   vars = {
#     firewall_subnets = "${element(var.subnet_ips, count.index)}"
#   }
# }
resource "aws_instance" "webserver" {
  count                  = "${var.instance_count}"
  instance_type          = "${var.instanceType}"
  ami                    = "${data.aws_ami.server_ami.id}"
  key_name               = "${aws_key_pair.mykeypair.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${element(var.subnets, count.index)}"
  #user_data              = "${data.template_file.user-init.*.rendered[count.index]}"
  tags = {
    Name = "${var.project_name}-server${count.index + 1}"
  }
  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > aws_hosts
[dev]
${element(aws_instance.webserver.*.public_ip, count.index)}
[dev:vars]
s3code = ${var.s3_bucket_name}
EOF
EOD
  }
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance_ids ${element(aws_instance.webserver.*.id, count.index)} && ansible-playbook -i aws_hosts wp_webserver.yml"
  }
}
