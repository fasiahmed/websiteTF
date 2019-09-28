# ---- elb/output.tf -------------
output "elb_dns_name" {
  value = "${aws_elb.tf_elb.dns_name}"
}
