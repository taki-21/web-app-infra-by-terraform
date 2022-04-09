variable "aws_region" {
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "aws_s3_bucket" {
  type    = string
  default = "web-app-remote-state"
}
