variable "vnet_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "address_space" { type = list(string) }
variable "subnets" {
  type = map(object({
    address_prefix                              = string
    service_endpoints                           = optional(list(string), [])
    private_endpoint_network_policies_enabled   = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)
    delegations = optional(list(object({
      name         = string
      service_name = string
      actions      = optional(list(string), [])
    })), [])
  }))
  description = "Map of subnets managed using for_each"
}
variable "tags" {
  type    = map(string)
  default = {}
}
