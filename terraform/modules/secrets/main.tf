resource "aws_secretsmanager_secret" "dockerhub" {
  name = "dockerhub-creds-v1"
  recovery_window_in_days = 0 
}

resource "aws_secretsmanager_secret_version" "dockerhub" {
  secret_id = aws_secretsmanager_secret.dockerhub.id

  secret_string = jsonencode({
    username = var.dockerhub_username
    password = var.dockerhub_password
  })
}
