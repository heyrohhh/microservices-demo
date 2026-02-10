resource "aws_cloudwatch_log_group" "ecs_frontend" {
  name = "/ecs/frontend"
   retention_in_days = 1
  tags  = {
    Environment  = "production"
    Application = "frontend"
  }
}


resource "aws_ecs_task_definition" "frontend_service" {
    depends_on = [
        aws_cloudwatch_log_group.ecs_frontend
    ]
  family   = "frontend-service"
  network_mode   = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu   = var.frontend_cpu
  memory   = var.frontend_memory
  execution_role_arn = aws_iam_role.task_execution_role.arn                 

  container_definitions = jsonencode([
    {
      name = "frontend"
      image = var.frontend_image
      essential = true

      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
          protocol = "tcp"
        }
      ]

      environment = [
        { name = "PORT", value = "8080" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group  = aws_cloudwatch_log_group.ecs_frontend.name
          awslogs-region = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
