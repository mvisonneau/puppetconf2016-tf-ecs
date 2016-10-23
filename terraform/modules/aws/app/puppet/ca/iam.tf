/*resource "aws_iam_role" "puppetca_server" {
  name               = "puppetca_server"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {"Service": "ec2.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }
}
EOF
}

resource "aws_iam_policy" "s3_rw_puppetca_backups" {
  name        = "s3_rw_puppetca_server"
  description = "S3 RW Accesses IAM Policy on the S3 Backup Bucket"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PrivateReadWriteForBucketObjects",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${var.backup_bucket}",
        "arn:aws:s3:::${var.backup_bucket}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "s3_rw_puppetca_backups" {
  name       = "s3_rw_puppetca_server"
  roles      = ["${aws_iam_role.puppetca_server.name}"]
  policy_arn = "${aws_iam_policy.s3_rw_puppetca_backups.arn}"
}

resource "aws_iam_instance_profile" "puppetca_server" {
  name  = "puppetca_server"
  roles = ["${aws_iam_role.puppetca_server.name}"]
}*/
