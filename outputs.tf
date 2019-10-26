#----storage outputs------

output "BucketName" {
  value = "${module.storage.bucket_out}"
}

#---Networking Outputs -----

output "PublicSubnetIDs" {
  value = "${join(", ", module.network.public_subnets)}"
}
output "PrivateSubnetIDs" {
  value = "${join(", ", module.network.private_subnets)}"
}
output "RdsSubnetIDs" {
  value = "${join(", ", module.network.rds_subnets)}"
}
output "allSubnets" {
  value = "${split(",", join(",", module.network.rds_subnets, module.network.private_subnets, module.network.public_subnets))}"
}
output "PublicSubnetIPs" {
  value = "${join(", ", module.network.public_subnet_ips)}"
}
output "PrivateSubnetIPs" {
  value = "${join(", ", module.network.private_subnet_ips)}"
}
output "RdsSubnetIPs" {
  value = "${join(", ", module.network.rds_subnet_ips)}"
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
output "VPCendpointID" {
  value = "${module.network.vpc_endpoint_id}"
}
#---Compute Outputs ------
output "PublicInstanceIDs" {
  value = "${module.compute.server_id}"
}
output "PublicInstanceIPs" {
  value = "${module.compute.server_ip}"
}
