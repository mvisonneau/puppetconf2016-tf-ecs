resource "aws_s3_bucket" "puppetca_certs" {
  bucket  = "${var.certs_bucket}"
  // Enable to enhance security of this bucket
  /*policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Access-to-specific-VPC-only",
      "Principal": "*",
      "Action": "s3:*",
      "Effect": "Deny",
      "Resource": ["arn:aws:s3:::${var.backup_bucket}",
                   "arn:aws:s3:::${var.backup_bucket}/*"],
      "Condition": {
        "StringNotEquals": {
          "aws:sourceVpc": "${var.vpc_id}"
        }
      }
    }
  ]
}
EOF*/
  region  = "${var.region}"

  tags {
    Name  = "${var.certs_bucket}"
    owner = "${var.owner}"
  }
}
