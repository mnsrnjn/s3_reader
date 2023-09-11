data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}






resource "aws_s3_bucket" "assignment" {
   bucket = var.bucket_name
  #  server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm     = "aws:kms"
  #       kms_master_key_id = var.kms_master_key_id
  #     }
  #   }
  # }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "assignment" {
  bucket = aws_s3_bucket.assignment.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}



resource "aws_s3_bucket_acl" "assignment_bucket_acl" {
  bucket = aws_s3_bucket.assignment.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.example]
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.assignment.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "assignment_bucket_policy" {
  bucket = aws_s3_bucket.assignment.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowTest",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
POLICY
}

resource "aws_s3_object" "assignment" {
  depends_on = [aws_s3_bucket_policy.assignment_bucket_policy]

  bucket = aws_s3_bucket.assignment.id
  key    = "assignment/assignment.txt"
  source = "${path.module}/assignment.txt"
}