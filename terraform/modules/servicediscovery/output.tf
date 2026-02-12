

output "namespace_id" {
  value = aws_service_discovery_private_dns_namespace.namespace.id
}

output "discovery_arns" {
  value = {
    for name, svc in aws_service_discovery_service.services :
    name => svc.arn
  }
}
