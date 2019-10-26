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
# Creating RDS subnets in the availability_zone
resource "aws_subnet" "tf_rds_subnet" {
  count                   = 2
  vpc_id                  = "${aws_vpc.tf_vpc.id}"
  cidr_block              = "${var.rds_cidr[count.index]}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  tags = {
    Name = "${var.project_name}-rdsSubnet_${count.index + 1}"
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
resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.tf_vpc.id}"
  dynamic "ingress" {
    for_each = var.ingress_sg_block
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  dynamic "egress" {
    for_each = var.egress_sg_block
    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
  tags = {
    Name = "Dev_SecurityGroup"
  }
}
# Creating a ELB Security group which is access publicly
resource "aws_security_group" "tf_public_sg" {
  name        = "${var.project_name}_public_sg"
  description = "Default securtiygroup for public access"
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
  tags = {
    Name = "Public_SecurityGroup"
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
  tags = {
    Name = "Private_SecurityGroup"
  }
}
# Creating a RDS Security group
resource "aws_security_group" "tf_rds_sg" {
  name        = "${var.project_name}_rds_sg"
  description = "Used for RDS Instance"
  vpc_id      = "${aws_vpc.tf_vpc.id}"
  # Open MySql default port
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_default_security_group.default.id}", "${aws_security_group.tf_public_sg.id}", "${aws_security_group.tf_private_sg.id}"]
    cidr_blocks     = ["${var.vpc_cidr}"]
  }
  tags = {
    Name = "RDS_SecurityGroup"
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
