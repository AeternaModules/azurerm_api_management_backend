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
        - username (required)
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
      accept_retry_after_enabled = optional(bool) # Default: false
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
      username = string
    }))
    service_fabric_cluster = optional(object({
      client_certificate_id            = optional(string)
      client_certificate_thumbprint    = optional(string)
      management_endpoints             = set(string)
      max_partition_resolution_retries = number
      server_certificate_thumbprints   = optional(set(string))
      server_x509_name = optional(object({
        issuer_certificate_thumbprint = string
        name                          = string
      }))
    }))
    tls = optional(object({
      validate_certificate_chain = optional(bool)
      validate_certificate_name  = optional(bool)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.api_management_backends : (
        v.circuit_breaker_rule.failure_condition.status_code_range == null || (length(v.circuit_breaker_rule.failure_condition.status_code_range) <= 10)
      )
    ])
    error_message = "Each status_code_range list must contain at most 10 items"
  }
}

