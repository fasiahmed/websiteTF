#------- Network variables ------
aws_region     = "eu-central-1"
aws_access_key = "Your's Producation aws_access_key"
aws_secret_key = "Your's Producation aws_secret_key"
project_name   = "prodsite"
vpc_cidr       = "172.25.0.0/16"
route_cidr     = "0.0.0.0/0"
accessip       = "0.0.0.0/0"
vpc_dns_switch = true
public_cidrs   = ["172.25.1.0/24", "172.25.2.0/24"]
ingress_sg_block = [
  {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  },
  {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
]
egress_sg_block = [
  {
    description = "Allow all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

#------- web server variables ------
key_name        = "tf_key"
public_key_path = "compute/tf_key.pub" #Give the path to your public key.
instance_count  = 1
instanceType    = "t2.micro"
#------- Database variables ------
rds_storage_size   = 10
rds_engine         = "mysql"
rds_engine_version = "5.6.27"
rds_instance_class = "db.t2.micro"
rds_db_name        = "wordpress"
rds_db_user        = "admin"
rds_db_password    = "admin123"
#-------- ELB variables ----------------------
instance_port       = 80
instance_protocol   = "http"
lb_port             = 80
lb_protocol         = "http"
healthy_threshold   = 2
unhealthy_threshold = 2
timeout             = 3
target              = "TCP:80"
interval            = 30
