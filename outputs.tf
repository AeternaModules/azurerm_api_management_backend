output "api_management_backends_id" {
  description = "Map of id values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.id if v.id != null && length(v.id) > 0 }
}
output "api_management_backends_api_management_name" {
  description = "Map of api_management_name values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.api_management_name if v.api_management_name != null && length(v.api_management_name) > 0 }
}
output "api_management_backends_circuit_breaker_rule" {
  description = "Map of circuit_breaker_rule values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.circuit_breaker_rule if v.circuit_breaker_rule != null && length(v.circuit_breaker_rule) > 0 }
}
output "api_management_backends_credentials" {
  description = "Map of credentials values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.credentials if v.credentials != null && length(v.credentials) > 0 }
}
output "api_management_backends_description" {
  description = "Map of description values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.description if v.description != null && length(v.description) > 0 }
}
output "api_management_backends_name" {
  description = "Map of name values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.name if v.name != null && length(v.name) > 0 }
}
output "api_management_backends_protocol" {
  description = "Map of protocol values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.protocol if v.protocol != null && length(v.protocol) > 0 }
}
output "api_management_backends_proxy" {
  description = "Map of proxy values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.proxy if v.proxy != null && length(v.proxy) > 0 }
  sensitive   = true
}
output "api_management_backends_resource_group_name" {
  description = "Map of resource_group_name values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.resource_group_name if v.resource_group_name != null && length(v.resource_group_name) > 0 }
}
output "api_management_backends_resource_id" {
  description = "Map of resource_id values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.resource_id if v.resource_id != null && length(v.resource_id) > 0 }
}
output "api_management_backends_service_fabric_cluster" {
  description = "Map of service_fabric_cluster values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.service_fabric_cluster if v.service_fabric_cluster != null && length(v.service_fabric_cluster) > 0 }
}
output "api_management_backends_title" {
  description = "Map of title values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.title if v.title != null && length(v.title) > 0 }
}
output "api_management_backends_tls" {
  description = "Map of tls values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.tls if v.tls != null && length(v.tls) > 0 }
}
output "api_management_backends_url" {
  description = "Map of url values across all api_management_backends, keyed the same as var.api_management_backends"
  value       = { for k, v in azurerm_api_management_backend.api_management_backends : k => v.url if v.url != null && length(v.url) > 0 }
}

