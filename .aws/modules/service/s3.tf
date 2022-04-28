data "aws_iam_policy_document" "deny_insecure_transport" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.developer_portal_bucket.arn,
      "${aws_s3_bucket.developer_portal_bucket.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
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


resource "aws_s3_bucket_public_access_block" "developer_portal_bucket" {
    bucket = aws_s3_bucket.developer_portal_bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}