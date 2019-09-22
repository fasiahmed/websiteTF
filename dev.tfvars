#------- Network variables ------
aws_region     = "eu-central-1"
aws_access_key = "Your's Producation aws_access_key"
aws_secret_key = "Your's Producation aws_secret_key"
project_name   = "devsite"
vpc_cidr       = "10.12.0.0/16"
route_cidr     = "0.0.0.0/0"
accessip       = "0.0.0.0/0"
vpc_dns_switch = true
public_cidrs   = ["10.12.1.0/24", "10.12.2.0/24"]
private_cidrs  = ["10.12.3.0/24", "10.12.4.0/24"]
rds_cidr       = ["10.12.5.0/24", "10.12.6.0/24"]
#------- web server variables ------
key_name        = "tf_key"
public_key_path = "yours_pubkey.pub" #Give the path to your public key.
instance_count  = 2
instanceType    = "t2.micro"
#------- Database variables ------
rds_storage_size   = 10
rds_engine         = "mysql"
rds_engine_version = "5.6.27"
rds_instance_class = "db.t2.micro"
rds_db_name        = "wordpress"
rds_db_user        = "admin"
rds_db_password    = "admin123"
