module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
     source = "./modules/sg"
     vpc_id = module.vpc.vpc_id
}

module "alb" {
  source                  = "./modules/alb"
  vpc_id                  = module.vpc.vpc_id
  public_subnet_ids        = module.vpc.public_subnet_ids
  alb_security_group_id    = module.sg.alb_security_group_id
}

module "ecs" {
  source = "./modules/ecs"

  alb_target_group_arn    = module.alb.alb_target_group_arn
  alb_listener_arn  = module.alb.alb_listener_arn

  private_subnet_ids    = module.vpc.private_subnet_ids
  ecs_security_group_id = module.sg.ecs_security_group_id

  aws_region     = var.aws_region
  frontend_image = var.frontend_image
}


