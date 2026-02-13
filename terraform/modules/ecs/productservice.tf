resource "aws_ecs_service" "product" {
  name = "product"
  cluster= aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.product.arn
  desired_count   = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.private_subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.aws_lb_target_group_product_arn
    container_name= "product"
    container_port = 3550
  }

  service_registries {
    registry_arn= var.discovery_arns["product"]
  }

  depends_on =[var.alb_listener_arn]
}

