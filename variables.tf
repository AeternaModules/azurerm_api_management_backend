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
  # --- Unconfirmed validation candidates, derived from azurerm_api_management_backend's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    [from validate.ApiManagementBackendName] !matched
  # path: api_management_name
  #   source:    [from validate.ApiManagementServiceName] !matched
  # path: resource_group_name
  #   condition: length(value) <= 90
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) > 90]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) > 90]
  # path: resource_group_name
  #   condition: !endswith(value, ".")
  #   message:   [from resourcegroups.ValidateName: must not end with "."]
  #   source:    [from resourcegroups.ValidateName: must not end with "."]
  # path: resource_group_name
  #   condition: length(value) != 0
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) == 0]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) == 0]
  # path: resource_group_name
  #   source:    [from resourcegroups.ValidateName] !matched
  # path: circuit_breaker_rule.name
  #   condition: can(regex("^[a-zA-Z0-9]([a-zA-Z0-9-]{0,78}[a-zA-Z0-9])?$", value))
  #   message:   `name` must be between 1 and 80 characters in length and may contain only numbers, letters, and hyphens (-) sign when preceded and followed by number or a letter.
  # path: circuit_breaker_rule.trip_duration
  #   source:    [from azValidate.ISO8601Duration] !ok
  # path: circuit_breaker_rule.trip_duration
  #   source:    [from azValidate.ISO8601Duration] err != nil
  # path: circuit_breaker_rule.failure_condition.interval_duration
  #   source:    [from azValidate.ISO8601Duration] !ok
  # path: circuit_breaker_rule.failure_condition.interval_duration
  #   source:    [from azValidate.ISO8601Duration] err != nil
  # path: circuit_breaker_rule.failure_condition.count
  #   condition: value >= 1 && value <= 10000
  #   message:   must be between 1 and 10000
  # path: circuit_breaker_rule.failure_condition.error_reasons[*]
  #   condition: length(value) >= 1 && length(value) <= 200
  #   message:   must be between 1 and 200 characters
  # path: circuit_breaker_rule.failure_condition.percentage
  #   condition: value >= 1 && value <= 100
  #   message:   must be between 1 and 100
  # path: circuit_breaker_rule.failure_condition.status_code_range.min
  #   condition: value >= 200 && value <= 599
  #   message:   must be between 200 and 599
  # path: circuit_breaker_rule.failure_condition.status_code_range.max
  #   condition: value >= 200 && value <= 599
  #   message:   must be between 200 and 599
  # path: credentials.authorization.parameter
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: credentials.authorization.scheme
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: credentials.certificate[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: credentials.header[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: credentials.query[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: description
  #   condition: length(value) >= 1 && length(value) <= 2000
  #   message:   must be between 1 and 2000 characters
  # path: protocol
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: proxy.password
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: proxy.url
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: proxy.username
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: resource_id
  #   condition: length(value) >= 1 && length(value) <= 2000
  #   message:   must be between 1 and 2000 characters
  # path: service_fabric_cluster.client_certificate_id
  #   source:    [from validate.CertificateID] !ok
  # path: service_fabric_cluster.client_certificate_id
  #   source:    [from validate.CertificateID] err != nil
  # path: service_fabric_cluster.client_certificate_thumbprint
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: service_fabric_cluster.management_endpoints[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: service_fabric_cluster.server_certificate_thumbprints[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: service_fabric_cluster.server_x509_name.issuer_certificate_thumbprint
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: service_fabric_cluster.server_x509_name.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: title
  #   condition: length(value) >= 1 && length(value) <= 300
  #   message:   must be between 1 and 300 characters
  # path: url
  #   condition: length(value) > 0
  #   message:   must not be empty
}

