locals {
    name_app = "web-app"
    name_nginx = "nginx"
}

resource "aws_ecr_repository" "nginx" {
    name = local.name_nginx
}

resource "aws_ecr_repository" "rails" {
    name = local.name_app
}
