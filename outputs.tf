#----storage outputs------

output "BucketName" {
  value = "${module.storage.bucket_out}"
}

#---Networking Outputs -----

output "PublicSubnets" {
  value = "${join(", ", module.network.public_subnets)}"
}

output "SubnetIPs" {
  value = "${join(", ", module.network.public_subnet_ips)}"
}

output "PublicSecurityGroup" {
  value = "${module.network.public_security_group}"
}

#---Compute Outputs ------

output "PublicInstanceIDs" {
  value = "${module.compute.server_id}"
}

output "PublicInstanceIPs" {
  value = "${module.compute.server_ip}"
}
