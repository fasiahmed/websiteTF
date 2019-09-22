# Get the availability_zone in the given region
data "aws_availability_zones" "available" {
  state = "available"
}
# Creating VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = "${var.vpc_dns_switch}"
  enable_dns_hostnames = "${var.vpc_dns_switch}"
  tags = {
    Name = "${var.project_name}-vpc"
  }
}
# Creating an internet gateway
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  tags = {
    Name = "${var.project_name}-igw"
  }
}
# Creating public route table and attached the internet gateway
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
# Creating default or private route table
resource "aws_default_route_table" "tf_defaultRT" {
  default_route_table_id = "${aws_vpc.tf_vpc.default_route_table_id}"
  tags = {
    Name = "${var.project_name}-defaultRT"
  }
}
# Creating public subnets in the availability_zone
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
# Creating private subnets in the availability_zone
resource "aws_subnet" "tf_private_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.tf_vpc.id}"
  cidr_block              = "${var.private_cidrs[count.index]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    Name = "${var.project_name}-privateSubnet_${count.index + 1}"
  }
}
# public route table associations
resource "aws_route_table_association" "tf_public_assoc" {
  count          = "${length(var.public_cidrs)}"
  subnet_id      = "${aws_subnet.tf_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.tf_publicRT.id}"
}
# private route table associations
resource "aws_route_table_association" "tf_private_assoc" {
  count          = "${length(var.private_cidrs)}"
  subnet_id      = "${aws_subnet.tf_private_subnet.*.id[count.index]}"
  route_table_id = "${aws_default_route_table.tf_defaultRT.id}"
}
# Creating a Dev Security group which is access by your IP addr and open ssh and http ports enabled
resource "aws_security_group" "tf_dev_sg" {
  name        = "${var.project_name}_dev_sg"
  description = "Used for access the dev instances"
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
# Creating a ELB Security group which is access publicly
resource "aws_security_group" "tf_public_sg" {
  name        = "${var.project_name}_public_sg"
  description = "Used for ELB public access"
  vpc_id      = "${aws_vpc.tf_vpc.id}"
  #HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Creating a private Security group which is access only from VPC
resource "aws_security_group" "tf_private_sg" {
  name        = "${var.project_name}_private_sg"
  description = "Used for private access"
  vpc_id      = "${aws_vpc.tf_vpc.id}"
  #Access only from VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Creating the VPC Endpoint for private S3 bucket
resource "aws_vpc_endpoint" "tf_private_s3endpoint" {
  vpc_id          = "${aws_vpc.tf_vpc.id}"
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = ["${aws_vpc.tf_vpc.main_route_table_id}", "${aws_route_table.tf_publicRT.id}"]
  policy          = <<POLICY
  {
    "Statement": [
      {
        "Action": "*",
        "Effect": "Allow",
        "Resource": "*",
        "Principal": "*"
      }
    ]
  }
POLICY
}
