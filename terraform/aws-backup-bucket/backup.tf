resource "aws_s3_bucket" "backup" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "archive"
    enabled = true

    transition {
      days          = 1
      storage_class = "DEEP_ARCHIVE"
    }
  }

  lifecycle_rule {
    id      = "expire"
    enabled = true

    noncurrent_version_expiration {
      days = 365
    }
  }
}

resource "aws_s3_bucket_public_access_block" "backup" {
  depends_on = [aws_s3_bucket.backup]
  bucket     = aws_s3_bucket.backup.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "backup" {
  depends_on = [aws_s3_bucket_public_access_block.backup]
  bucket     = aws_s3_bucket.backup.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "RestrictAccess",
      "Action": "s3:*",
      "Effect": "Deny",
      "NotPrincipal": {
        "AWS": [
          "arn:aws:iam::${var.aws_account_id}:user/${var.default_user}",
          "arn:aws:iam::${var.aws_account_id}:root"
        ]
      },
      "Resource": [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*"
      ]
    },
    {
      "Sid": "EnforceSSL",
      "Action": "s3:*",
      "Effect": "Deny",
      "Principal": "*",
      "Resource": [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    },
    {
      "Sid": "EnforceDefaultEncryption",
      "Action": "s3:PutObject",
      "Effect": "Deny",
      "Principal": "*",
      "Resource": "arn:aws:s3:::${var.bucket_name}/*",
      "Condition": {
        "StringNotEquals": {
          "s3:x-amz-server-side-encryption": "AES256"
        }
      }
    }
  ]
}
POLICY
}
