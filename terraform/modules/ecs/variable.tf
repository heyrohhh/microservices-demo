variable "aws_region" {
  type = string
}

variable "frontend_image" {
  type = string
}

variable "frontend_cpu" {
  type    = string
  default = "512"
}

variable "frontend_memory" {
  type    = string
  default = "1024"
}

variable "frontend_log_group" {
  type    = string
  default = "/ecs/frontend"
}

variable "private_subnet_ids" {
    type = list(string)
}

variable "ecs_security_group_id" {
     type = string
}

variable "alb_target_group_arn" {
    type = string
}


variable "alb_listener_arn" {
     type = string
}