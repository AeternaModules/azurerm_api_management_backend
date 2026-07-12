output "api_management_backends_api_management_name" {
  description = "Map of api_management_name values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.api_management_name }
}
output "api_management_backends_circuit_breaker_rule" {
  description = "Map of circuit_breaker_rule values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.circuit_breaker_rule }
}
output "api_management_backends_credentials" {
  description = "Map of credentials values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.credentials }
}
output "api_management_backends_description" {
  description = "Map of description values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.description }
}
output "api_management_backends_name" {
  description = "Map of name values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.name }
}
output "api_management_backends_protocol" {
  description = "Map of protocol values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.protocol }
}
output "api_management_backends_proxy" {
  description = "Map of proxy values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.proxy }
  sensitive   = true
}
output "api_management_backends_resource_group_name" {
  description = "Map of resource_group_name values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.resource_group_name }
}
output "api_management_backends_resource_id" {
  description = "Map of resource_id values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.resource_id }
}
output "api_management_backends_service_fabric_cluster" {
  description = "Map of service_fabric_cluster values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.service_fabric_cluster }
}
output "api_management_backends_title" {
  description = "Map of title values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.title }
}
output "api_management_backends_tls" {
  description = "Map of tls values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.tls }
}
output "api_management_backends_url" {
  description = "Map of url values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.url }
}

