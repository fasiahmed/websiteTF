data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_vpc" "tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = "${var.vpc_dns_switch}"
  enable_dns_hostnames = "${var.vpc_dns_switch}"
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_route_table" "tf_publicRT" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  route {
    cidr_block = "${var.route_cidr}"
    gateway_id = "${aws_internet_gateway.tf_igw.id}"
  }
  tags = {
    Name = "${var.project_name}-publicRT"
  }
}

resource "aws_default_route_table" "tf_defaultRT" {
  default_route_table_id = "${aws_vpc.tf_vpc.default_route_table_id}"
  tags = {
    Name = "${var.project_name}-defaultRT"
  }
}

resource "aws_subnet" "tf_public_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.tf_vpc.id}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    Name = "${var.project_name}-publicSubnet_${count.index + 1}"
  }
}
resource "aws_route_table_association" "tf_public_assoc" {
  count          = "${length(var.public_cidrs)}"
  subnet_id      = "${aws_subnet.tf_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.tf_publicRT.id}"
}

resource "aws_security_group" "tf_public_sg" {
  name        = "${var.project_name}_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = "${aws_vpc.tf_vpc.id}"
  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }
  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
