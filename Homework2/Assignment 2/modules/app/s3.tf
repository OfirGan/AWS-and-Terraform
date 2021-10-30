##################################################################################
# S3 BUCKET
##################################################################################

resource "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.purpose_tag}-${var.s3_logs_bucket_name}"
  acl    = "private"

  tags {
    Name = "${var.purpose_tag}-${var.s3_logs_bucket_name}"
  }
}
