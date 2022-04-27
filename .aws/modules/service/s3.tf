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
  bucket = "${local.prefix}-api-builds"
  tags   = local.tags
}

resource "aws_s3_bucket_acl" "bucket_versioning_acl" {
  bucket = aws_s3_bucket.developer_portal_bucket.id
  acl    = "private"
}
