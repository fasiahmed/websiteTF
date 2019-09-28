#----storage outputs------

output "BucketName" {
  value = "${module.storage.bucket_out}"
}

#---Networking Outputs -----

output "PublicSubnets" {
  value = "${join(", ", module.network.public_subnets)}"
}
output "PrivateSubnets" {
  value = "${join(", ", module.network.private_subnets)}"
}
output "RdsSubnets" {
  value = "${join(", ", module.network.rds_subnets)}"
}
output "allSubnets" {
  value = "${split(",", join(",", module.network.rds_subnets, module.network.private_subnets, module.network.public_subnets))}"
}
output "rds_subnets_0" {
  value = "${element(module.network.rds_subnets, 1)}"
}
output "SubnetIPs" {
  value = "${join(", ", module.network.public_subnet_ips)}"
}
output "PublicSecurityGroup" {
  value = "${module.network.public_security_group}"
}
output "PrivateSecurityGroup" {
  value = "${module.network.private_security_group}"
}
output "RdsSecurityGroup" {
  value = "${module.network.rds_security_group}"
}
#---Compute Outputs ------
output "PublicInstanceIDs" {
  value = "${module.compute.server_id}"
}
output "PublicInstanceIPs" {
  value = "${module.compute.server_ip}"
}
