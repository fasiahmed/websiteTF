aws_region      = "eu-central-1"
aws_access_key  = "Your's Staging aws_access_key"
aws_secret_key  = "Your's Staging aws_secret_key"
project_name    = "devsite"
vpc_cidr        = "10.123.0.0/16"
route_cidr      = "0.0.0.0/0"
accessip        = "0.0.0.0/0"
vpc_dns_switch  = true
public_cidrs    = ["10.123.1.0/24", "10.123.2.0/24"]
key_name        = "tf_key"
public_key_path = "./Staging_pubkey.pub" #give yours own public key
instance_count  = 2
instanceType    = "t2.micro"
