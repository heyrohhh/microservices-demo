#alb Security group

resource "aws_security_group" "alb_sg" {
    name = "alb-sg"
    vpc_id =  var.vpc_id

    tags = {
        Name = "alb_sg"
    }

    ingress {
         from_port = 80
         to_port = 80
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
         from_port = 0
         to_port = 0
         protocol = "-1"
         cidr_blocks = ["0.0.0.0/0"]
    }
}


#ecs Security group

resource "aws_security_group" "ecs_sg" {
    name = "ecs-sg"
    vpc_id =  var.vpc_id

    tags = {
        Name = "ecs_sg"
    }

    ingress {
         security_groups = [aws_security_group.alb_sg.id]
         from_port = 80
         to_port = 80
         protocol = "tcp"
    }

    egress {

         from_port = 0
         to_port = 0
         protocol = "-1"
         cidr_blocks = ["0.0.0.0/0"]
    }
}