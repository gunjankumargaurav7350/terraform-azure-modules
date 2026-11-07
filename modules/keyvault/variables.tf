variable "key_vault_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "sku_name" {
  type    = string
  default = "premium"
}
variable "enabled_for_disk_encryption" {
  type    = bool
  default = true
}
variable "enable_rbac_authorization" {
  type    = bool
  default = true
}
variable "network_acls_default_action" {
  type    = string
  default = "Deny"
}
variable "allowed_ip_ranges" {
  type    = list(string)
  default = []
}
variable "allowed_subnet_ids" {
  type    = list(string)
  default = []
}
variable "access_policies" {
  type = map(object({
    object_id               = string
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
  }))
  default     = {}
  description = "Access policies configured via for_each"
}
variable "tags" {
  type    = map(string)
  default = {}
}
