
#target group frontend

resource "aws_lb_target_group" "alb_tg" {
  name = "frontend-tg"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

  health_check {
    path = "/"
    interval = 10
    timeout = 5
    healthy_threshold = 3
    unhealthy_threshold = 2
    matcher  = "200"
  }
}



#targetgroupcart
resource "aws_lb_target_group" "cart_tg" {
     name = "cart-tg"
     port = 7070
     protocol = "HTTP"
     vpc_id = var.vpc_id
     target_type = "ip"
     health_check {
       path = "/cart"
        interval = 10
        timeout = 5
        healthy_threshold = 3
        unhealthy_threshold = 2
        matcher = "200"
     }
     tags = {
       Name = "cart-tg"
     }
}

#target Group

resource "aws_lb_target_group" "product_tg" {
    name = "product-tg"
     port = 3550
     protocol = "HTTP"
     vpc_id = var.vpc_id
     target_type = "ip"
     health_check {
       path = "/"
        interval = 10
        timeout = 5
        healthy_threshold = 3
        unhealthy_threshold = 2
        matcher = "200-499"
     }
     tags = {
       Name = "product-tg"
     }
}



# load Balancer

resource "aws_lb" "alb_lb" {
      name = "aws-lb"
      internal = false
      load_balancer_type = "application"
      security_groups = [var.alb_security_group_id]
      subnets = var.public_subnet_ids
      enable_deletion_protection = false
      
      tags = {
         Name = "aws-lb"
  }

}

# aws listner


resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.alb_lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
 }

 #routing rule


 resource "aws_lb_listener_rule" "product_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority = 10

  action {
    type= "forward"
    target_group_arn = aws_lb_target_group.product_tg.arn
  }

  condition {
    path_pattern {
      values = ["/product*"]
    }
  }
}


resource "aws_lb_listener_rule" "cart_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority= 20

  action {
    type= "forward"
    target_group_arn = aws_lb_target_group.cart_tg.arn
  }

  condition {
    path_pattern {
      values = ["/cart*"]
    }
  }
}
