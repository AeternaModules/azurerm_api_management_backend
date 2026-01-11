resource "azurerm_api_management_backend" "api_management_backends" {
  for_each = var.api_management_backends

  api_management_name = each.value.api_management_name
  name                = each.value.name
  protocol            = each.value.protocol
  resource_group_name = each.value.resource_group_name
  url                 = each.value.url
  description         = each.value.description
  resource_id         = each.value.resource_id
  title               = each.value.title

  dynamic "circuit_breaker_rule" {
    for_each = each.value.circuit_breaker_rule != null ? [each.value.circuit_breaker_rule] : []
    content {
      accept_retry_after_enabled = circuit_breaker_rule.value.accept_retry_after_enabled
      failure_condition {
        count             = circuit_breaker_rule.value.failure_condition.count
        error_reasons     = circuit_breaker_rule.value.failure_condition.error_reasons
        interval_duration = circuit_breaker_rule.value.failure_condition.interval_duration
        percentage        = circuit_breaker_rule.value.failure_condition.percentage
        dynamic "status_code_range" {
          for_each = circuit_breaker_rule.value.failure_condition.status_code_range != null ? circuit_breaker_rule.value.failure_condition.status_code_range : []
          content {
            max = status_code_range.value.max
            min = status_code_range.value.min
          }
        }
      }
      name          = circuit_breaker_rule.value.name
      trip_duration = circuit_breaker_rule.value.trip_duration
    }
  }

  dynamic "credentials" {
    for_each = each.value.credentials != null ? [each.value.credentials] : []
    content {
      dynamic "authorization" {
        for_each = credentials.value.authorization != null ? [credentials.value.authorization] : []
        content {
          parameter = authorization.value.parameter
          scheme    = authorization.value.scheme
        }
      }
      certificate = credentials.value.certificate
      header      = credentials.value.header
      query       = credentials.value.query
    }
  }

  dynamic "proxy" {
    for_each = each.value.proxy != null ? [each.value.proxy] : []
    content {
      password = proxy.value.password
      url      = proxy.value.url
      username = proxy.value.username
    }
  }

  dynamic "service_fabric_cluster" {
    for_each = each.value.service_fabric_cluster != null ? [each.value.service_fabric_cluster] : []
    content {
      client_certificate_id            = service_fabric_cluster.value.client_certificate_id
      client_certificate_thumbprint    = service_fabric_cluster.value.client_certificate_thumbprint
      management_endpoints             = service_fabric_cluster.value.management_endpoints
      max_partition_resolution_retries = service_fabric_cluster.value.max_partition_resolution_retries
      server_certificate_thumbprints   = service_fabric_cluster.value.server_certificate_thumbprints
      dynamic "server_x509_name" {
        for_each = service_fabric_cluster.value.server_x509_name != null ? [service_fabric_cluster.value.server_x509_name] : []
        content {
          issuer_certificate_thumbprint = server_x509_name.value.issuer_certificate_thumbprint
          name                          = server_x509_name.value.name
        }
      }
    }
  }

  dynamic "tls" {
    for_each = each.value.tls != null ? [each.value.tls] : []
    content {
      validate_certificate_chain = tls.value.validate_certificate_chain
      validate_certificate_name  = tls.value.validate_certificate_name
    }
  }
}

