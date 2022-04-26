data "aws_iam_policy_document" "deny_insecure_transport" {
  statement {
    effect = "Deny"

    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.developer_portal_bucket.arn,
      "${aws_s3_bucket.developer_portal_bucket.arn}/*",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = compact([
    data.aws_iam_policy_document.deny_insecure_transport.json
  ])
}

resource "aws_s3_bucket_policy" "developer_portal_bucket" {
  bucket     = aws_s3_bucket.developer_portal_bucket.id
  policy     = data.aws_iam_policy_document.combined.json
  
  depends_on = [
    aws_s3_bucket.developer_portal_bucket
  ]
}

resource "aws_s3_bucket" "developer_portal_bucket" {
  bucket = "${local.prefix}-api-build"
  tags   = local.tags
}


resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.developer_portal_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "bucket_versioning_acl" {
  bucket = aws_s3_bucket.developer_portal_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "developer_portal_bucket" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.developer_portal_bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [
    aws_s3_bucket_policy.developer_portal_bucket,
    aws_s3_bucket.developer_portal_bucket
  ]
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.developer_portal_bucket.id
  
  rule {
    expiration {
      days = 35
    }
    id     = "${local.region_short}-${local.account_id}-${local.prefix}-default-lifecycle"
    status = "Enabled"
  }
  
  rule {
    expiration {
      days = 0
      expired_object_delete_marker = true
    }
    id     = "${local.region_short}-${local.account_id}-${local.prefix}-expired-object-delete-marker-lifecycle"
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryptation_config" {
  bucket = aws_s3_bucket.developer_portal_bucket.id

  rule {
    apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }
}