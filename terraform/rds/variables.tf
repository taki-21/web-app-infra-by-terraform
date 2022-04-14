variable "private_subnet_ids" {}

variable "db_name" {}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "db_instance" {
  type    = string
  default = "db.t2.micro"
}

variable "db_username" {}

variable "db_password" {}
