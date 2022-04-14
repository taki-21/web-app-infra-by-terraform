module "network" {
  source   = "./network"
  app_name = var.app_name
}

module "rds" {
  source = "./rds"

  app_name = var.app_name
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  vpc_id = module.network.vpc_id
  alb_security_group = module.elb.alb_security_group
  private_subnet_ids = module.network.private_subnet_ids
}
