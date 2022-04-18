resource "aws_acm_certificate" "this" {
  provider    = aws.virginia
  domain_name = var.domain

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
