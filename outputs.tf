output "api_management_backends" {
  description = "All api_management_backend resources"
  value       = azurerm_api_management_backend.api_management_backends
  sensitive   = true
}
output "api_management_backends_api_management_name" {
  description = "List of api_management_name values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.api_management_name]
}
output "api_management_backends_circuit_breaker_rule" {
  description = "List of circuit_breaker_rule values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.circuit_breaker_rule]
}
output "api_management_backends_credentials" {
  description = "List of credentials values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.credentials]
}
output "api_management_backends_description" {
  description = "List of description values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.description]
}
output "api_management_backends_name" {
  description = "List of name values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.name]
}
output "api_management_backends_protocol" {
  description = "List of protocol values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.protocol]
}
output "api_management_backends_proxy" {
  description = "List of proxy values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.proxy]
  sensitive   = true
}
output "api_management_backends_resource_group_name" {
  description = "List of resource_group_name values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.resource_group_name]
}
output "api_management_backends_resource_id" {
  description = "List of resource_id values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.resource_id]
}
output "api_management_backends_service_fabric_cluster" {
  description = "List of service_fabric_cluster values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.service_fabric_cluster]
}
output "api_management_backends_title" {
  description = "List of title values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.title]
}
output "api_management_backends_tls" {
  description = "List of tls values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.tls]
}
output "api_management_backends_url" {
  description = "List of url values across all api_management_backends"
  value       = [for k, v in azurerm_api_management_backend.api_management_backends : v.url]
}

