module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
     source = "./modules/sg"
     vpc_id = module.vpc.vpc_id
}

module "alb" {
  source     = "./modules/alb"
  vpc_id   = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  alb_security_group_id  = module.sg.alb_security_group_id
}

module "ecs" {
  source = "./modules/ecs"
  dockerhub_secret_arn = module.secrets.dockerhub_secret_arn 
  depends_on = [module.secrets]
  private_subnet_ids = module.vpc.private_subnet_ids
  ecs_security_group_id = module.sg.ecs_security_group_id
  alb_target_group_arn = module.alb.alb_target_group_arn
  aws_lb_target_group_product_arn = module.alb.aws_lb_target_group_product_arn
  alb_target_group_cart_arn = module.alb.alb_target_group_cart_arn
  alb_listener_arn = module.alb.alb_listener_arn
  aws_region = var.aws_region
  frontend_image  = var.frontend_image
  ad_image = var.ad_image
  cart_image =  var.cart_image
  checkout_image = var.checkout_image
  currency_img = var.currency_img
  email_Img  = var.email_Img
  load_Img = var.load_Img
  payment_image = var.payment_image
  product_image = var.product_image
  recomandation_image = var.recomandation_image
  shipping_image = var.shipping_image
  assitant_image = var.assitant_image
  cpu = var.cpu
  memory = var.memory
  discovery_arns = module.sd.discovery_arns
}




module "sd" {
  source = "./modules/servicediscovery"

  namespace_name = "internal"
  vpc_id         = module.vpc.vpc_id

  service_names = [
    "checkout",
    "payment",
    "shipping",
    "email",
    "currency",
    "recomandation",
    "redis",
    "assitant",
    "loadGenrator",
    "adservice"
  ]
}

module "secrets" {
  source = "./modules/secrets"
  dockerhub_username = var.dockerhub_username 
  dockerhub_password = var.dockerhub_password
}

module "ecr" {
  source = "./modules/ecr"

  repositories = [
    "frontend",
    "cart",
    "product",
    "checkout",
    "payment",
    "currency",
    "email",
    "recommendation",
    "assistant",
    "loadgenerator",
    "shipping",
    "adservice",
    "redis"
  ]
}
