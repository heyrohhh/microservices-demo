resource "aws_secretsmanager_secret" "dockerhub" {
  name = "dockerhub-creds"
}

resource "aws_secretsmanager_secret_version" "dockerhub" {
  secret_id = aws_secretsmanager_secret.dockerhub.id

  secret_string = jsonencode({
    username = var.dockerhub_username
    password = var.dockerhub_password
  })
}
