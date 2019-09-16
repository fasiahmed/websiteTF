aws_region      = "eu-central-1"
aws_access_key  = "Your's Producation aws_access_key"
aws_secret_key  = "Your's Producation aws_secret_key"
project_name    = "prodsite"
vpc_cidr        = "172.25.0.0/16"
route_cidr      = "0.0.0.0/0"
accessip        = "0.0.0.0/0"
vpc_dns_switch  = true
public_cidrs    = ["172.25.1.0/24", "172.25.2.0/24"]
key_name        = "tf_key"
public_key_path = "./production_pubkey.pub" #give yours own public key
instance_count  = 2
instanceType    = "t2.small"
