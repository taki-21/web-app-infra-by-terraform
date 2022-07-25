locals {
  bucket_name = "${var.app_name}-s3-2022"
  s3_origin_id = "S3-${var.app_name}"
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = var.app_name
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.template_file.s3_policy.rendered
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_distribution" "this" {
  aliases = [var.domain]

  origin {
    domain_name = aws_s3_bucket.this.bucket_domain_name
    origin_id = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }
}
