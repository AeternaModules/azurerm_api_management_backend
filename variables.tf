variable "api_management_backends" {
  description = <<EOT
Map of api_management_backends, attributes below
Required:
    - api_management_name
    - name
    - protocol
    - resource_group_name
    - url
Optional:
    - description
    - resource_id
    - title
    - circuit_breaker_rule (block):
        - accept_retry_after_enabled (optional)
        - failure_condition (required, block):
            - count (optional)
            - error_reasons (optional)
            - interval_duration (required)
            - percentage (optional)
            - status_code_range (optional, block):
                - max (required)
                - min (required)
        - name (required)
        - trip_duration (required)
    - credentials (block):
        - authorization (optional, block):
            - parameter (optional)
            - scheme (optional)
        - certificate (optional)
        - header (optional)
        - query (optional)
    - proxy (block):
        - password (optional)
        - url (required)
        - username (optional)
    - service_fabric_cluster (block):
        - client_certificate_id (optional)
        - client_certificate_thumbprint (optional)
        - management_endpoints (required)
        - max_partition_resolution_retries (required)
        - server_certificate_thumbprints (optional)
        - server_x509_name (optional, block):
            - issuer_certificate_thumbprint (required)
            - name (required)
    - tls (block):
        - validate_certificate_chain (optional)
        - validate_certificate_name (optional)
EOT

  type = map(object({
    api_management_name = string
    name                = string
    protocol            = string
    resource_group_name = string
    url                 = string
    description         = optional(string)
    resource_id         = optional(string)
    title               = optional(string)
    circuit_breaker_rule = optional(object({
      accept_retry_after_enabled = optional(bool)
      failure_condition = object({
        count             = optional(number)
        error_reasons     = optional(list(string))
        interval_duration = string
        percentage        = optional(number)
        status_code_range = optional(list(object({
          max = number
          min = number
        })))
      })
      name          = string
      trip_duration = string
    }))
    credentials = optional(object({
      authorization = optional(object({
        parameter = optional(string)
        scheme    = optional(string)
      }))
      certificate = optional(list(string))
      header      = optional(map(string))
      query       = optional(map(string))
    }))
    proxy = optional(object({
      password = optional(string)
      url      = string
      username = optional(string)
    }))
    service_fabric_cluster = optional(object({
      client_certificate_id            = optional(string)
      client_certificate_thumbprint    = optional(string)
      management_endpoints             = set(string)
      max_partition_resolution_retries = number
      server_certificate_thumbprints   = optional(set(string))
      server_x509_name = optional(list(object({
        issuer_certificate_thumbprint = string
        name                          = string
      })))
    }))
    tls = optional(object({
      validate_certificate_chain = optional(bool)
      validate_certificate_name  = optional(bool)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.circuit_breaker_rule == null || (v.circuit_breaker_rule.failure_condition.status_code_range == null || (length(v.circuit_breaker_rule.failure_condition.status_code_range) <= 10))
      )
    ])
    error_message = "Each status_code_range list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.circuit_breaker_rule == null || (can(regex("^[a-zA-Z0-9]([a-zA-Z0-9-]{0,78}[a-zA-Z0-9])?$", v.circuit_breaker_rule.name)))
      )
    ])
    error_message = "`name` must be between 1 and 80 characters in length and may contain only numbers, letters, and hyphens (-) sign when preceded and followed by number or a letter."
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.circuit_breaker_rule == null || (v.circuit_breaker_rule.failure_condition.count == null || (v.circuit_breaker_rule.failure_condition.count >= 1 && v.circuit_breaker_rule.failure_condition.count <= 10000))
      )
    ])
    error_message = "must be between 1 and 10000"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.circuit_breaker_rule == null || (v.circuit_breaker_rule.failure_condition.error_reasons == null || (alltrue([for x in v.circuit_breaker_rule.failure_condition.error_reasons : length(x) >= 1 && length(x) <= 200])))
      )
    ])
    error_message = "must be between 1 and 200 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.circuit_breaker_rule == null || (v.circuit_breaker_rule.failure_condition.percentage == null || (v.circuit_breaker_rule.failure_condition.percentage >= 1 && v.circuit_breaker_rule.failure_condition.percentage <= 100))
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.circuit_breaker_rule == null || (v.circuit_breaker_rule.failure_condition.status_code_range == null || alltrue([for item in v.circuit_breaker_rule.failure_condition.status_code_range : (item.min >= 200 && item.min <= 599)]))
      )
    ])
    error_message = "must be between 200 and 599"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.circuit_breaker_rule == null || (v.circuit_breaker_rule.failure_condition.status_code_range == null || alltrue([for item in v.circuit_breaker_rule.failure_condition.status_code_range : (item.max >= 200 && item.max <= 599)]))
      )
    ])
    error_message = "must be between 200 and 599"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.credentials == null || (v.credentials.authorization == null || (v.credentials.authorization.parameter == null || (length(v.credentials.authorization.parameter) > 0)))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.credentials == null || (v.credentials.authorization == null || (v.credentials.authorization.scheme == null || (length(v.credentials.authorization.scheme) > 0)))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.credentials == null || (v.credentials.certificate == null || (alltrue([for x in v.credentials.certificate : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.credentials == null || (v.credentials.header == null || (alltrue([for x in v.credentials.header : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.credentials == null || (v.credentials.query == null || (alltrue([for x in v.credentials.query : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.description == null || (length(v.description) >= 1 && length(v.description) <= 2000)
      )
    ])
    error_message = "must be between 1 and 2000 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.proxy == null || (v.proxy.password == null || (length(v.proxy.password) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.proxy == null || (length(v.proxy.url) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.proxy == null || (v.proxy.username == null || (length(v.proxy.username) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.resource_id == null || (length(v.resource_id) >= 1 && length(v.resource_id) <= 2000)
      )
    ])
    error_message = "must be between 1 and 2000 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.service_fabric_cluster == null || (v.service_fabric_cluster.client_certificate_thumbprint == null || (length(v.service_fabric_cluster.client_certificate_thumbprint) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.service_fabric_cluster == null || (alltrue([for x in v.service_fabric_cluster.management_endpoints : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.service_fabric_cluster == null || (v.service_fabric_cluster.server_certificate_thumbprints == null || (alltrue([for x in v.service_fabric_cluster.server_certificate_thumbprints : length(x) > 0])))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.service_fabric_cluster == null || (v.service_fabric_cluster.server_x509_name == null || alltrue([for item in v.service_fabric_cluster.server_x509_name : (length(item.issuer_certificate_thumbprint) > 0)]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.service_fabric_cluster == null || (v.service_fabric_cluster.server_x509_name == null || alltrue([for item in v.service_fabric_cluster.server_x509_name : (length(item.name) > 0)]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.title == null || (length(v.title) >= 1 && length(v.title) <= 300)
      )
    ])
    error_message = "must be between 1 and 300 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        length(v.url) > 0
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 10 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

