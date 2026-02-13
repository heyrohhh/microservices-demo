resource "aws_ecs_service" "cart_service" {
  name = "cart-service"
  cluster = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.cart.arn
  desired_count = 2
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.private_subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_cart_arn
    container_name = "ecsCart"
    container_port= 7070
  }

  service_registries {
    registry_arn = var.discovery_arns["cart"]
  }

  depends_on = [var.alb_listener_arn]
}