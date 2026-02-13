
resource "aws_cloudwatch_log_group" "ecs_checkout" {
        name = "/ecs/checkout"
        retention_in_days = 1
        tags = {
          environment="dev"
          application="checkout"
        }

}

resource "aws_ecs_task_definition" "checkout" {
         depends_on = [ aws_cloudwatch_log_group.ecs_checkout ]
         family = "checkout"
         network_mode   = var.network_mode
         cpu = var.cpu
         memory = var.memory
         requires_compatibilities = var.compatibilities
         execution_role_arn = aws_iam_role.task_execution_role.arn
         container_definitions = jsonencode([
        {
            name="ecsCheckout"
            image=var.checkout_image
            essential=true 

            portMappings = [
                {
                    containerPort = 5050
                    protocol="tcp"
                }
            ]

            environment=[
                 { name = "PORT", value = "5050" }
            ]

            logConfiguration= {
                    logDriver="awslogs"
                    options = {
                      awslogs-group  = aws_cloudwatch_log_group.ecs_checkout.name
                      awslogs-region = var.aws_region
                      awslogs-stream-prefix = "ecs"
                               }
                }
            
        }
    ])
}