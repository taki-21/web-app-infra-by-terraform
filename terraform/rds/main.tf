resource "aws_db_subnet_group" "db_subnet_group" {
  name = var.db_name
  description = "db subnet group of ${var.db_name}"
  subnet_ids = var.private_subnet_ids
}
