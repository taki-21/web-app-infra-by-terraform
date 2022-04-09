# tfstateを管理するS3の作成
resource "aws_s3_bucket" "terraform-state" {
  bucket = var.aws_s3_bucket
  tags = {
    Terraform = "true"
    Name      = "terraform"
  }
}
