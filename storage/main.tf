# ---- storage/main.tf -------------
# create a Random ID for S3 bucket
resource "random_id" "randomcode" {
  byte_length = 2
}
# create a s3 bucket
resource "aws_s3_bucket" "tf_bucket" {
  bucket = "${var.project_name}-${random_id.randomcode.dec}"
  acl    = "private"
  force_destroy = "true"
}
