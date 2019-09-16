#----storage outputs------

output "BucketName" {
  value = "${module.storage.bucket_out}"
}

#---Networking Outputs -----

output "PublicSubnets" {
  value = "${join(", ", module.network.subnets)}"
}

output "SubnetIPs" {
  value = "${join(", ", module.network.subnet_ips)}"
}

output "PublicSecurityGroup" {
  value = "${module.network.security_group}"
}

#---Compute Outputs ------

output "PublicInstanceIDs" {
  value = "${module.compute.server_id}"
}

output "PublicInstanceIPs" {
  value = "${module.compute.server_ip}"
}
