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
#------- web server variables ------
key_name        = "tf_key"
public_key_path = "./production_pubkey.pub" #give yours own public key
instance_count  = 2
instanceType    = "t2.small"
#------- Database variables ------
rds_storage_size   = 10
rds_engine         = "mysql"
rds_engine_version = "5.6.27"
rds_instance_class = "db.t2.micro"
rds_db_name        = "wordpress"
rds_db_user        = "proadmin"
rds_db_password    = "proadmin123"
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
