output "namespace_id" {
  description = "Service discovery namespace ID"
  value = aws_service_discovery_private_dns_namespace.namespace.id
}

output "namespace_name" {
  description = "Service discovery namespace name"
  value  = aws_service_discovery_private_dns_namespace.namespace.name
}

output "namespace_arn" {
  description = "Service discovery namespace ARN"
  value = aws_service_discovery_private_dns_namespace.namespace.arn
}

# Output individual service ARNs by name
output "service_arns" {
  description = "Map of service names to their registry ARNs"
  value = {
    adservice = aws_service_discovery_service.services["adservice"].arn
    cart = aws_service_discovery_service.services["cart"].arn
    checkout = aws_service_discovery_service.services["checkout"].arn
    currency = aws_service_discovery_service.services["currency"].arn
    email  = aws_service_discovery_service.services["email"].arn
    frontend = aws_service_discovery_service.services["frontend"].arn
    loadGenrator= aws_service_discovery_service.services["loadGenrator"].arn
    payment = aws_service_discovery_service.services["payment"].arn
    product = aws_service_discovery_service.services["product"].arn
    recomandation= aws_service_discovery_service.services["recomandation"].arn
    redis = aws_service_discovery_service.services["redis"].arn
    shipping= aws_service_discovery_service.services["shipping"].arn
    shoppingassistant = aws_service_discovery_service.services["shoppingassistant"].arn
  }
}
